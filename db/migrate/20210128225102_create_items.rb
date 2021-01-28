class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.decimal :price
      t.integer :quantity
      t.text :description
      t.decimal :rating

      t.timestamps
    end
  end
end
