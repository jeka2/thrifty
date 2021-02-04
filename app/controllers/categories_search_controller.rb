class CategoriesSearchController < ApplicationController
    def new
        @categories = Category.all
    end

    def create
        binding.pry
    end
end