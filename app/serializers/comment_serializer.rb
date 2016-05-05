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
    object.has_liked?(scope)
  end

  def likes_count
    object.likes.count
  end

  def can_edit
    CommentPolicy.new(scope, object).update?
  end
end
