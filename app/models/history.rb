class History < ActiveRecord::Base

  attr_readonly :comments_count
  has_many :comments, dependent: :destroy, as: :commentable
  belongs_to :user

  validates :title, presence: true, length: { in: 2..100 }
  validates :history, presence: true, length: { maximum: 100000 }

  paginates_per 10

  def as_json
    HistorySerializer.new(self).as_json
  end
end
