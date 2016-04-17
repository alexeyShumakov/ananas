class AddAvatarToPosts < ActiveRecord::Migration
  def up
    add_attachment :posts, :avatar
  end

  def down
    remove_attachment :posts, :avatar
  end
end
