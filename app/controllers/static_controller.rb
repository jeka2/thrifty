class StaticController < ApplicationController
    def home
        @items = Item.all.sample(4)
    end
end