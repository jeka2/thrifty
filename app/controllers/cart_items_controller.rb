class CartItemsController < ApplicationController
    before_action :authenticate

    def create
        current_user.cart = Cart.create if current_user.cart.nil?
        cart_id = current_user.cart.id
        new_cart_item = CartItem.new(quantity: params[:quantity], item_id: params[:item_id], cart_id: cart_id)

        respond_to do |format|
            if new_cart_item.save 
                format.html { redirect_to root_path } 
                format.js
            else
                format.html { redirect_to root_path } 
                format.js
            end
        end
    end

    def delete

    end

private 
    def authenticate
        unless params[:user_id].to_i == current_user.id
            flash[:alert] = "You don't have the right to do this"
            redirect_to root_path
        end
    end

end