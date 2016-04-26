class User < ActiveRecord::Base
  has_attached_file :avatar, styles: { small: "65x65>" }, default_url: "/images/user/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  has_many :posts
  has_many :comments, dependent: :destroy

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook, :vkontakte, :google_oauth2]

  enum role: [:user, :major_moderator, :minor_moderator]
  validates :username, :weekly_mailing, presence: true

  def owner_of?(model)
    model.user == self
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name
      user.skip_confirmation!
      user.save
    end
  end
end
