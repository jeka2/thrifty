class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :item

    acts_as_tree order: 'created_at DESC'
end