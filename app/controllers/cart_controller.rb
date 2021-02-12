class CartController < ApplicationController
    def show
        if params[:user_id].to_i == current_user.id
            @cart = current_user.cart
            @items = @cart.items if @cart
        else
            flash[:alert] = ["You may not view this"]
            redirect_to root_path
        end
    end
end