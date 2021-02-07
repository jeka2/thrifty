class CategoriesController < ApplicationController
    before_action :authenticate_admin
    
    def index
        @categories = Category.all
    end

    def show
        @category = Category.find_by_id(params[:id])
    end

    def new
        @category = Category.new
    end

    def create
        category = Category.new(category_params)

        if category.save 
            redirect_to categories_path
        else
            render :new
        end
    end

    def edit
        @category = Category.find(params[:id])
    end

    def update
        category = Category.find(params[:id])

        if category.update(category_params)
            redirect_to categories_path
        else
            render :edit
        end
    end

private 

    def category_params
        params.require(:category).permit(:name, :description)
    end
end