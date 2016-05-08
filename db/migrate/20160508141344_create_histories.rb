class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :name
      t.string :email
      t.text :history

      t.timestamps null: false
    end
  end
end
