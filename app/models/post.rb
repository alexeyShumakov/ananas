class Post < ActiveRecord::Base
  extend FriendlyId
  include PgSearch
  is_impressionable

  attr_readonly :comments_count

  friendly_id :slug, use: :slugged

  pg_search_scope :search_by_title,
    against: :title,
    using: {tsearch: {prefix: true}},
    ranked_by: 'impressions_count'

  has_attached_file :avatar, styles: { medium: "850x425#" }, default_url: "/images/post/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  belongs_to :category, counter_cache: true
  belongs_to :user
  has_many :comments, dependent: :destroy, as: :commentable
  has_many :favorites, dependent: :destroy

  validates :slug, uniqueness: true
  validates :sinopsis, :body, :title, presence: true
  validates :user, presence: true
  validates :category_id, presence: true
  validates :category, presence: true
  validates :avatar, attachment_presence: true

  paginates_per 10

  def self.best_weekly
    where('created_at > ?', 1.year.ago).order(impressions_count: :desc).limit(10)
  end

  def similar
    category.posts.where('created_at > ?', 4.weeks.ago).where('id != ?', self.id).shuffle[0..5]
  end

  def self.best_authors
    sql = "select users.id,users.username,sum(impressions_count) as looks,sum(favorites_count) as favorites,sum(comments_count) as comments,count(title) as posty,(sum(impressions_count) + sum(favorites_count) * 2 + sum(comments_count) * 3) as raiting from posts INNER JOIN users ON posts.user_id=users.id group by users.username,users.id order by raiting DESC;"
    records_array = ActiveRecord::Base.connection.execute(sql)
  end

  def has_favorite?(user)
    if favorites.find_by(user: user)
      true
    else
      false
    end
  end
end
