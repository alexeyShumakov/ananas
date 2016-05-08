class History < ActiveRecord::Base
  validates :email, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
  validates :email, :name, presence: true, length: { in: 2..100 }
  validates :history, presence: true, length: { maximum: 100000 }

  paginates_per 10
end
