class QueryItemsController < ApplicationController
    def create
        @query = params[:q]
        @current_page = params[:page].to_i == 0 ? 1 : params[:page].to_i
        @user = User.find_by_id(params[:user_id])
        @per_page = 10
        @querried_items = Item.where("name LIKE ? AND creator_id = ?", "%#{@query}%", @user.id)
        @items = @querried_items.paginate(page: @current_page, per_page: @per_page)
        respond_to do |format|
            format.html { redirect_to root_path }
            format.js
        end
    end
end