module ItemsHelper
    def modify_options_for(item)
        if item.creator_id == current_user.id
            content_tag :div do 
                concat link_to 'edit this item', edit_user_item_path(current_user, item) 
                concat link_to 'delete this item', user_item_path(current_user, item), method: 'delete'
            end
        end 
    end

    def display_image_slideshow(item)
        images = item.images
        path_urls = Array.new
        if !item.images.empty?
            path_split_arr = images.first.identifier.split('"')
            path_split_arr.each.with_index do |val, i|
                path_urls << val if i % 2 != 0
            end
            path = item.id
        else
            path_urls << "default.jpg"
            path = "fallback"
        end
        
        render partial: 'items/slideshow', locals: { images: path_urls, path: path }
    end
end
