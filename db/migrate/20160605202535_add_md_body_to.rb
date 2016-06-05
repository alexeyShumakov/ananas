class AddMdBodyTo < ActiveRecord::Migration
  def change
    add_column :posts, :md_body, :string
  end
end
