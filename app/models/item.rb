class Item < ApplicationRecord
    belongs_to :user, foreign_key: 'creator_id'
    belongs_to :department

    has_many :category_items
    has_many :categories, through: :category_items
    has_many_attached :images

    validates :name, { presence: true, uniqueness: true }
    validates :price, presence: true
    validates :quantity, presence: true
    validates :description, presence: true

    def department=(department)
        if department.is_a?(String)
            self.department_id = department.to_i
        else
            self.department_id = department.id
        end
    end
end