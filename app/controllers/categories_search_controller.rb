class CategoriesSearchController < ApplicationController
    include CategoriesHelper

    def new
        @categories = Category.all
    end

    def create
        @categories = params[:item][:category_ids]
        if @categories
            querried_items = get_queried_items(@categories[0..2])
            @items = Item.where(id: querried_items).order_as_specified(id: querried_items) # Order by relevance
        else
            # Paginate method acts funky if .limit is used
            @items = Item.where(id: [1..100])
        end

        @per_page = 10
        @items = @items.paginate(page: params[:page], per_page: @per_page)
        
        respond_to do |format|
            format.html { redirect_to root_path }
            format.js
        end
    end
end