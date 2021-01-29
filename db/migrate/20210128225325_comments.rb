class Comments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :likes

      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
