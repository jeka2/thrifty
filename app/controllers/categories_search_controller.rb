class CategoriesSearchController < ApplicationController
    include CategoriesHelper

    def new
        @categories = Category.all
    end

    def create
        @items = get_queried_items(params[:category_ids][0..2])
        respond_to do |format|
            format.html { redirect_to root_path }
            format.js
        end
    end
end