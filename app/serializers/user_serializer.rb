class UserSerializer < ApplicationSerializer
  attributes :id, :email, :username, :role, :roles, :avatar_small_url, :avatar_medium_url
  
  def avatar_small_url
    object.avatar.url(:small)
  end

  def avatar_medium_url
    object.avatar.url(:medium)
  end

  def roles
    User.roles.map { |role| { name: role[0], value: role[1]} }
  end
end
