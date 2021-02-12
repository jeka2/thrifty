class CartItemsController < ApplicationController
    before_action :authenticate

    def create
        current_user.cart = Cart.create if current_user.cart.nil?
        cart_id = current_user.cart.id
        @item_id = params[:item_id]
        new_cart_item = CartItem.new(quantity: params[:quantity], item_id: @item_id, cart_id: cart_id)

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
        cart_item = CartItem.find_by(cart_id: params[:cart_id], item_id: params[:item_id])
        @item_id = params[:item_id]
        cart_item.delete
 
        respond_to do |format|
            format.html { redirect_to root_path }
            format.js
        end
    end

private 
    def authenticate
        if params[:user_id]
            if !(params[:user_id].to_i == current_user.id)
                flash[:alert] = "You don't have the right to do this"
                redirect_to root_path
            end
        elsif params[:cart_id]
            if current_user && current_user.cart.id != params[:cart_id].to_i
                flash[:alert] = "You don't have the right to do this"
                redirect_to root_path
            end
        elsif !params[:user_id] || !params[:cart_id]
            flash[:alert] = "You don't have the right to do this"
            redirect_to root_path
        end
    end

end