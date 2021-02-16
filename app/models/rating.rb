class Rating < ApplicationRecord
    belongs_to :user 
    belongs_to :item

    validates :score, presence: true
end