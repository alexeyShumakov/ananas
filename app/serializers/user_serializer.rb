class UserSerializer < ApplicationSerializer
  attributes :id, :email, :username, :role, :roles
  
  def roles
    User.roles.map { |role| { name: role[0], value: role[1]} }
  end
end
