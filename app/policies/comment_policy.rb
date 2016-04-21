class CommentPolicy < ApplicationPolicy
  def update?
    user.major_moderator? || user.minor_moderator? || user.owner_of?(@record)
  end

  def destroy?
    user.major_moderator? || user.minor_moderator? || user.owner_of?(@record)
  end
  class Scope < Scope
    def resolve
      scope
    end
  end
end
