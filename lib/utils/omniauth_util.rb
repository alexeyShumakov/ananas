class Utils::OmniauthUtil
  def self.find_or_create_user(auth)
    User.where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.password = Devise.friendly_token[0,20]
      user.email = ""
      user.username = auth.info.name
      user.avatar = tmp_image(auth.info.image)
      user.skip_confirmation!
      user.save
    end
  end

  private

  def self.tmp_image(url)
    img = RestClient.get(url)
    img_path = Rails.root.join('tmp/temp_img')
    File.open(img_path, 'wb') { |f| f.write(img)}
    File.open img_path
  end
end
