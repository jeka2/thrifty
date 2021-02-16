module RatingsHelper
    def update_rating(item: item, old_score: old_score, new_score: new_score, new_record:false)
        old_item_rating = item.rating
        old_ratings_count = item.ratings_count
        new_ratings_count = new_record ? old_ratings_count + 1 : old_ratings_count
        new_item_rating = (old_item_rating * old_ratings_count - old_score + new_score) / new_ratings_count
        binding.pry
        item.update(rating: new_item_rating, ratings_count: new_ratings_count)
    end
end