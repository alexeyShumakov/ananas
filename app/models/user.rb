class User < ActiveRecord::Base
  has_attached_file :avatar, styles: { small: "50x50>" }, default_url: "/images/user/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment_size :avatar, less_than: 15.megabytes
  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :likes, dependent: :destroy

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook, :vkontakte, :google_oauth2]

  enum role: [:user, :major_moderator, :minor_moderator]
  validates :username, presence: true
  validates :weekly_mailing, inclusion: [true, false]
  def owner_of?(model)
    model.user == self
  end

  protected

  def email_required?
    provider.blank?
  end
end
