class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :title
      t.text :history
      t.integer :comments_count, default: 0
      t.references :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
