class CategoriesSearchController < ApplicationController
    def new
        @categories = Category.all
    end

    def create
        respond_to do |format|
            format.html { redirect_to root_path }
            format.js
        end
    end
end