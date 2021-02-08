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
        path_split_arr = images.first.identifier.split('"')
        path_names = Array.new
        path_split_arr.each.with_index do |val, i|
            path_names << val if i % 2 != 0
        end
        
        render partial: 'items/slideshow', locals: { images: path_names, item_id: item.id }
    end
end
