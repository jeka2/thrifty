class Category < ApplicationRecord
    has_many :category_items
    has_many :items, through: :category_items

    validates :name, uniqueness: true
end