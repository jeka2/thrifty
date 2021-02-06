module CategoriesHelper
    def get_queried_items(query_params)
        items_arr = Array.new
        return_items = Array.new

        query_params.each do |category_id|
            items_arr << Item.includes(:category_items).where(:category_items => {:category_id => category_id }).map(&:id)
        end

        get_items_to_return(items_arr)
    end

protected
    def get_items_to_return(items_ids)
        return_items = Array.new
        option = items_ids.count

        # Adding items into items_ids by relevance. IE: if all 3 categories match an item, 
        # it's the most relevant. If less match, it's slightly less relevant.
        while option > 0
            case option
                when 3
                    # Get intersection of all 3. The most relavant items 
                    return_items << (items_ids[0] & items_ids[1] & items_ids[2])
                when 2
                    # Get intersection of 2
                    if return_items.count === 3
                        return_items << (items_ids[0] & items_ids[1] - return_items.flatten)
                        return_items << (items_ids[1] & items_ids[2] - return_items.flatten)
                    else
                        return_items << (items_ids[0] & items_ids[1])
                    end
                when 1
                    if return_items.count == 3
                        return_items << (items_ids[0] - return_items.flatten) 
                        return_items << (items_ids[1] - return_items.flatten)
                        return_items << (items_ids[2] - return_items.flatten)
                    elsif return_items.count == 2
                        return_items << (items_ids[0] - return_items.flatten)
                        return_items << (items_ids[1] - return_items.flatten)
                    else
                        return_items << items_ids[0]
                    end
                else

            end
            option = 0 if return_items.flatten.length >= 100
            option -= 1
        end
        return_items.flatten[0..99]
    end

end