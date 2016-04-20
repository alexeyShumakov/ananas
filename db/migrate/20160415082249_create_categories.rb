class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :posts_count, default: 0
      t.string :title

      t.timestamps null: false
    end
  end
end
