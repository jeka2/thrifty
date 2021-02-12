module ItemsHelper
    def modify_options_for(item)
        if item.creator_id == current_user.id
            content_tag :div do 
                concat link_to 'edit this item', edit_user_item_path(current_user, item) 
                concat link_to 'delete this item', user_item_path(current_user, item), method: 'delete'
            end
        end 
    end

    def display_first_image(item)
        url_info = get_image_urls(target_item:item, type:'user_page')
        image_tag("/images/item/images/#{url_info[:path]}/#{url_info[:path_urls][0]}", class: 'item-image')
    end

    def display_image_slideshow(item)
        url_info = get_image_urls(target_item:item)
        render partial: 'items/slideshow', locals: { images: url_info[:path_urls], path: url_info[:path] }
    end

    def display_user_image_slideshow(user)
        if !user.items.empty?
            urls_list = Array.new
            content_tag(:div, id:'images-container', class:'top-content') do 
                user.items.limit(12).each do |item|
                    urls_list << get_image_urls(target_item: item, type:'user_page')
                end

                render partial: 'items/user_page_slideshow', locals: { list: urls_list }
            end
        end
    end

    def quantity_in_cart(cart_id, item_id)
        CartItem.find_by(cart_id: cart_id, item_id: item_id).quantity
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
            path_urls << "#{type + '_' if type }default.jpg"
            path = "fallback"
        end
        { path_urls: path_urls, path: path, name: target_item.name, id: target_item.id }
    end
end
