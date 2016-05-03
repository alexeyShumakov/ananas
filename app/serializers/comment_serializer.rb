class CommentSerializer < ApplicationSerializer
  attributes :id, :body, :author, :avatar, :can_edit, :url, :has_liked, :likes_count

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

  def has_liked
    if scope
      object.has_liked?(scope)
    else
      false
    end
  end

  def likes_count
    object.likes.count
  end

  def can_edit
    if scope
      CommentPolicy.new(scope, object).update?
    else
      false
    end
  end
end
