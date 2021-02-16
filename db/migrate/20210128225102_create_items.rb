class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.decimal :price
      t.integer :quantity
      t.string :name
      t.text :description
      t.decimal :rating
      t.integer :ratings_count
      t.string :images
      t.references :creator, null: false, foreign_key: { to_table: :users }
      t.references :department, null: false, foreign_key: true
      t.timestamps
    end
  end
end
