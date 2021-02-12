class PurchasesController < ApplicationController
    include PurchasesHelper
    def create
        if params[:user_id].to_i == current_user.id 
            make_purchase

            flash[:alert] = ["Your order is on your way"]

            redirect_to root_path
        else
            flash[:alert] = ["You are not allowed to do that"]
        end
    end
end