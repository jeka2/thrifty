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
        url_info = get_image_urls(target_item:item)
        render partial: 'items/slideshow', locals: { images: url_info[:path_urls], path: url_info[:path] }
    end

    def display_user_image_slideshow(user)
        if !user.items.empty?
            user.items.limit(12).each do |item|
                if !item.images.empty? 

                else

                end
            end
        end
    end
protected
    def get_image_urls(target_item:,type:nil)
        path_urls = Array.new
        path = nil
        if !target_item.images.empty?
            path_split_arr = target_item.images.first.identifier.split('"')
            path_split_arr.each.with_index do |val, i|
                if i % 2 != 0
                    url = type == nil ? val : type + '_' + val
                    path_urls << url
                end
                path = target_item.id
            end
        else
            path_urls << "#{type + '_' if type }default"
            path = "fallback"
        end
        { path_urls: path_urls, path: path }
    end
end
