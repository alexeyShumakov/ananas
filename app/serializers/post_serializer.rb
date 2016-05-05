class PostSerializer < ApplicationSerializer
  attributes :id, :favorites_count, :has_favorite, :title, :url, :impressions

  def url
    post_path(object)
  end

  def favortes_count
    object.favorites.count
  end

  def has_favorite
    object.has_favorite?(scope)
  end
end
