class CategoriesSearchController < ApplicationController
    include CategoriesHelper

    def new
        @categories = Category.all
    end

    def create
        @items = get_queried_items(params[:category_ids])
        respond_to do |format|
            format.html { redirect_to root_path }
            format.js
        end
    end
end