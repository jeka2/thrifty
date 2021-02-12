module PurchasesHelper
    def make_purchase
        current_user.cart.items.each do |item|
            cart_item = CartItem.find_by(cart_id: current_user.cart.id, item_id: item.id)
            quantity_purchased = cart_item.quantity
            item.update(quantity: item.quantity - quantity_purchased)
            cart_item.delete
        end
    end
end