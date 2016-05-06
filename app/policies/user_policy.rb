class UserPolicy < ApplicationPolicy

  def update?
    user.major_moderator?
  end

  def search?
    user.major_moderator?
  end

  def moderator_panel?
    user.major_moderator? || user.minor_moderator?
  end
  class Scope < Scope
    def resolve
      scope
    end
  end
end
