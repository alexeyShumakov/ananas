class HistoryPolicy < ApplicationPolicy

  def edit?
    user.major_moderator? || user.minor_moderator?
  end

  def update?
    user.major_moderator? || user.minor_moderator?
  end

  def destroy?
    user.major_moderator? || user.minor_moderator?
  end
  class Scope < Scope
    def resolve
      scope
    end
  end
end
