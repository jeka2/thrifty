class CategoriesSearchController < ApplicationController
    include CategoriesHelper

    def new
        @categories = Category.all
    end

    def create
        if params[:category_ids]
            querried_items = get_queried_items(params[:category_ids][0..2])
            @items = Item.where(id: querried_items).order_as_specified(id: querried_items) # Order by relevance
        else
            @items = Item.order(updated_at: :desc).limit(100)
        end
        @items = @items.paginate(page: params[:page], per_page: 10)
        
        respond_to do |format|
            format.html { redirect_to root_path }
            format.js
        end
    end
end