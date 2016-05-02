class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth_user 'facebook'
  end
  def vkontakte
    auth_user 'vkontakte'
  end

  def google_oauth2 
    auth_user 'google+'
  end

  def failure
    redirect_to root_path
  end

  private

  def auth_user(provider)
    @user = Utils::OmniauthUtil.find_or_create_user(request.env["omniauth.auth"])
    @user.remember_me = true

    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication
      set_flash_message(:notice, :success, :kind => provider) if is_navigational_format?
    else
      redirect_to new_user_registration_url, alert: "email #{@user.errors[:email].first}"
    end

  end
end
