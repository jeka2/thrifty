class ItemsController < ApplicationController
    before_action :home_unless_logged_in, except: [:show, :index]
    before_action :set_item, only: [:show, :edit, :update, :destroy]
    before_action :authorized_to_edit?, only: [:edit, :update, :destroy]

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
        @per_page = 10

        @page = params[:page] || 1
        @all_items = @items
        @items = @items.paginate(page: @page, per_page: @per_page)
    end

    def new
        redirect_to root_path unless params[:user_id].to_i == current_user.id
    end

    def create
        item = Item.new(item_params)
        item.creator_id = current_user.id

        if item.save 
            flash[:notice] = ["Item created successfully"]

            redirect_to user_items_path(current_user)
        else
            set_flash_alert_for(item)

            render :new
        end
    end

    def show
        @already_rated = !!Rating.find_by(item_id: @item.id, user_id: current_user.id) if logged_in?
    end

    def edit

    end

    def update
        binding.pry
        if @item.update(item_params)
            redirect_to item_path(@item)
        else
            set_flash_alert_for(@item)

            render :edit
        end
    end


private 
    def set_item
        @item = Item.find_by_id(params[:id])

        if !@item
            flash[:alert] = ["No such item"]

            redirect_to root_path
        end
    end

    def authorized_to_edit?
        if !(@item && logged_in? && current_user.id == @item.creator_id)
            flash[:alert] = ["You are not allowed to edit this resource"]

            redirect_to root_path
        end
    end

    def item_params
        params.require(:item).permit(:name, :price, :quantity, :description, :department, images: [], category_ids: [])
    end

end