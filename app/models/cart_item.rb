class CartItem < ApplicationRecord
    belongs_to :item
    belongs_to :cart

    validates :item_id, uniqueness: { scope: :cart_id, message: "already in cart" }
end