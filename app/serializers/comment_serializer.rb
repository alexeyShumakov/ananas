class CommentSerializer < ApplicationSerializer
  attributes :id, :body, :author, :avatar, :can_edit, :url

  private

  def url
    comment_path(object)
  end
  def avatar
    object.user.avatar(:small)
  end

  def author
    object.user.username
  end

  def can_edit
    if scope
      CommentPolicy.new(scope, object).update?
    else
      false
    end
  end
end
