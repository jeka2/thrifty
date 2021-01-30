module ItemsHelper
    def modify_options_for(item)
        if item.creator_id == current_user.id
            content_tag :div do 
                concat link_to 'edit this item', edit_item_path(item) 
                concat link_to 'delete this item', item, method: 'delete'
            end
        end 
    end
end

# <%= link_to 'edit this item', edit_item_path(item) %> |
#  <%= link_to 'delete this item', item, method: 'delete' %> <br>