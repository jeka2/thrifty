module CartHelper
    def already_in_cart?(item)
        CartItem.find_by(cart_id: current_user.cart.id, item_id: item.id)
    end
    
    def quantity_in_cart(cart_id, item_id)
        CartItem.find_by(cart_id: cart_id, item_id: item_id).quantity
    end

    def item_summary
        content_tag :div, id:'summary' do 
            current_user.cart.items.each do |item|
                concat content_tag :p,"#{pluralize(quantity_in_cart(current_user.cart.id, item.id), item.name)}", id: "item-#{item.id}-summary"
            end
        end
    end

    def total_cost
        content_tag :div, id:'total' do 
            concat content_tag :p, "Total: #{tally_price}", id:'total-amount'
        end
    end

    def tally_price
        result = 0
        cart_id = current_user.cart.id
        current_user.cart.items.each do |item|
            quantity = CartItem.find_by(item_id: item.id, cart_id: cart_id).quantity
            total_price = quantity * item.price
            result += total_price
        end
        result
    end
end