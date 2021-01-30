class ItemsController < ApplicationController
    before_action :check_logged_in, except: [:show]
    def new
        @item = Item.new
    end

    def create
        item = Item.new(item_params)
        if item.save 
            redirect_to root_path
        else
            set_flash_alert_for(item)

            render :new

            remove_flash_alert
        end
    end

    def show
        @item = Item.find(params[:id])
    end

    def edit
        @item = Item.find(params[:id])
    end

    def update
        item = Item.find(params[:id])

        if item.update(item_params)
            redirect_to item_path(item)
        else
            set_flash_alert_for(item)

            render :edit
            
            remove_flash_alert
        end
    end

    def delete
        item = Item.find(params[:id])


    end

private 
    def authorized_to_edit?
        logged_in? && current_user.id == @item.user_id
    end

    def item_params
        params.require(:item).permit(:price, :quantity, :description)
    end

end