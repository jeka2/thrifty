class CategoriesSearchController < ApplicationController
    def new
        @categories = Category.all
    end

    def create
        binding.pry
        ['2','3','6']
        Item.includes([:categories]).where( {:hashed_id=>params[:id]} )
    # Item.includes/joins([:categories]).where("category_id = params[:id][0] OR category_id = pararms[;id][1] OR categery")

 #CategoryItems.where(caterogry_id: pararms[0] OR catergeroy)

 #CategoryItems.all.select do |c|
        if c.category_id == pararms[id][0] || c.category_id == params[id]
            c.item
        end 
    end
end