class PostSerializer < ApplicationSerializer
  attributes :id, :favorites_count, :has_favorite, :title

  def favortes_count
    object.favorites.count
  end

  def has_favorite
    if scope
      object.has_favorite?(scope)
    else
      false
    end
  end
end
