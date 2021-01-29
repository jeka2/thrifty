class Item < ApplicationRecord
    belongs_to :user
    
    has_many :category_items
    has_many :categories, through: :category_items
end