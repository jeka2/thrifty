class PurchasesController < ApplicationController
    include PurchasesHelper
    before_action :authenticate

    def create
        binding.pry
        if params[:from_cart] # Request came from cart
            make_purchase

            flash[:alert] = ["Your order is on your way"]
            redirect_to root_path
        else
            item = Item.find_by(id: params[:item_id])
            if item 
                item.update(quantity: item.quantity - params[:quantity].to_i) 

                redirect_to confirmation_page_path
            end
        end
    end
private 
    def authenticate
        if params[:user_id].to_i != current_user.id 
            flash[:alert] = ["You are not allowed to do that"]
        end
    end
end