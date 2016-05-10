class HistoryPolicy < ApplicationPolicy

  def permitted_attributes
    if user.user?
      [:title, :history]
    else
      [:title, :history, :moderated]
    end
  end

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
