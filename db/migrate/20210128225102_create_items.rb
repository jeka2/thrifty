class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.decimal :price
      t.integer :quantity
      t.text :description
      t.decimal :rating
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
