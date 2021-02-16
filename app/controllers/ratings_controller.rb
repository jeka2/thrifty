class RatingsController < ApplicationController
    include RatingsHelper
    def create
        item = Item.find_by_id(params[:item_id])
        star_count = params[:star].to_i

        Rating.create(user_id: current_user.id, item_id: item.id, score: star_count)

        update_rating(item: item, old_score: 0, new_score: star_count, new_record:true)

        @new_rating = item.rating
        @new_ratings_count = item.ratings_count

        respond_to do |format|
            format.html { redirect_to root_path }
            format.js
        end 
    end

    def update
        item = Item.find_by_id(params[:id])
        star_count = params[:star].to_i

        old_rating = Rating.find_by(item_id: item.id, user_id: current_user.id)

        update_rating(item: item, old_score: old_rating.score, new_score: star_count)

        old_rating.update(score: star_count)

        @new_rating = item.rating

        respond_to do |format|
            format.html { redirect_to root_path }
            format.js
        end 
    end

end