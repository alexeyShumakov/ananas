class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :sinopsis
      t.text :body
      t.string :title
      t.integer :impressions, default: 0, null: false
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
