class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  validates :sinopsis, :body, :title, presence: true
end
