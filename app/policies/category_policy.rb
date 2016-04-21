class CategoryPolicy < ApplicationPolicy
  def new?
    user.major_moderator?
  end

  def update?
    user.major_moderator?
  end

  def create?
    user.major_moderator?
  end

  def update?
    user.major_moderator?
  end

  def destroy?
    user.major_moderator?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
