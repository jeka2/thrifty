class ItemsController < ApplicationController
    require 'mini_magick'
    before_action :home_unless_logged_in, except: [:show, :index]
    before_action :set_item, only: [:show, :edit, :update, :delete]
    before_action :authorized_to_edit?, only: [:edit, :update, :delete]

    def index
        if params[:user_id]
            @user = User.find_by_id(params[:user_id])
            if @user
                @items = @user.items
            else
                redirect_to root_path
            end
        else
            @items = Item.all
        end
    end

    def new
    end

    def create
        binding.pry
        item = Item.new(item_params)
        item.creator_id = current_user.id

        if item.save 
            redirect_to user_items_path(current_user)
        else
            set_flash_alert_for(item)

            render :new

            remove_flash_alert
        end
    end

    def show
    end

    def edit

    end

    def update
        if @item.update(item_params)
            redirect_to item_path(@item)
        else
            binding.pry
            set_flash_alert_for(@item)

            render :edit
            
            remove_flash_alert
        end
    end

    def destroy
        binding.pry
    end

private 
    def set_item
        @item = Item.find_by_id(params[:id])
    end

    def authorized_to_edit?
        if !(@item && logged_in? && current_user.id == @item.creator_id)
            @item.errors.add(:creator, 'You are not permitted to edit this resource')
            set_flash_alert_for(@item)

            redirect_to root_path
        end
    end

    def item_params
        params.require(:item).permit(:name, :price, :quantity, :description, :department, images: [], category_ids: [])
    end

end