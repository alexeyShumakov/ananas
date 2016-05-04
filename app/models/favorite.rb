class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, counter_cache: true
  validates :user, :post, presence: true
  validates :user_id, uniqueness: { scope: [:post_id] }
end
