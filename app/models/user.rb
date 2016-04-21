class User < ActiveRecord::Base
  has_attached_file :avatar, styles: { small: "65x65>" }, default_url: "/images/user/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  has_many :posts
  has_many :comments

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [:user, :major_moderator, :minor_moderator]

  def owner_of?(model)
    model.user == self
  end
end
