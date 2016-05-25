class Category < ActiveRecord::Base
  extend FriendlyId
  validates :title, presence: true
  has_many :posts, dependent: :destroy
  friendly_id :slug, use: :slugged
end
