class PostPolicy < ApplicationPolicy
  def new?
    user.major_moderator? || user.minor_moderator?
  end

  def edit?
    user.major_moderator? || (user.minor_moderator? && user.owner_of?(@record))
  end

  def create?
    user.major_moderator? || user.minor_moderator?
  end

  def update?
    user.major_moderator? || (user.minor_moderator? && user.owner_of?(@record))
  end

  def destroy?
    user.major_moderator? || (user.minor_moderator? && user.owner_of?(@record))
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
