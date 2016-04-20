class Post < ActiveRecord::Base
  default_scope { order(created_at: :DESC) }
  has_attached_file :avatar, styles: { medium: "850x425>" }, default_url: "/images/post/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  belongs_to :category, counter_cache: true
  belongs_to :user
  has_many :comments
  validates :sinopsis, :body, :title, presence: true
end
