class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.decimal :price
      t.integer :quantity
      t.text :description
      t.decimal :rating
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
