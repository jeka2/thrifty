class Item < ApplicationRecord
    belongs_to :user, foreign_key: 'creator_id'

    has_many :category_items
    has_many :categories, through: :category_items
end