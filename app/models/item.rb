class Item < ApplicationRecord
    extend OrderAsSpecified
    belongs_to :user, foreign_key: 'creator_id'
    belongs_to :department

    has_many :category_items
    has_many :categories, through: :category_items
    has_many_attached :images
    has_many :comments
    has_many :ratings

    validates :name, { presence: true }
    validates :price, presence: true
    validates :quantity, presence: true
    validates :description, presence: true
    validates :creator_id, presence: true
    validates :department_id, presence: true

    mount_uploaders :images, ImageUploader

    after_create :initial_rating_assign

    def department=(department)
        if department.is_a?(String)
            self.department_id = department.to_i
        else
            self.department_id = department.id
        end
    end

private 
    def initial_rating_assign
        self.update(rating: 5, ratings_count: 1)
        Rating.create(user_id: self.creator_id, item_id: self.id, score: 5)
    end
end