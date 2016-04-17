class Post < ActiveRecord::Base
  belongs_to :category
  validates :sinopsis, :body, :title, presence: true
end
