class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, polymorphic: true, counter_cache: true
  validates :body, presence: true
  has_many :likes, dependent: :destroy

  def has_liked?(user)
    if likes.find_by(user: user)
      true
    else
      false
    end
  end
end
