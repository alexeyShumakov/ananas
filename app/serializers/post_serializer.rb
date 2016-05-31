class PostSerializer < ApplicationSerializer
  has_one :user
  attributes :id, :body,
    :favorites_count, :has_favorite, :created_at,
    :title, :url, :impressions, :sinopsis, :avatar_medium_url

  def impressions
    object.impressions_count
  end
  def url
    post_path(object)
  end

  def avatar_medium_url
    object.avatar.url(:medium)
  end

  def favortes_count
    object.favorites.count
  end

  def has_favorite
    object.has_favorite?(scope)
  end
end
