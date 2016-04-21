class Category < ActiveRecord::Base
  validates :title, presence: true
  has_many :posts, dependent: :destroy
end
