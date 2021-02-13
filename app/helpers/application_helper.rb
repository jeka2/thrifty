module ApplicationHelper
    def flash_present?
        (flash[:alert] && !flash[:alert].empty?) || (flash[:notice] && !flash[:notice].empty?)
    end

    def flash_types
        types = []
        types << { 'alert': flash[:alert] } if flash[:alert] && !flash[:alert].empty? 
        types << { 'notice': flash[:notice] } if flash[:notice] && !flash[:notice].empty?
        types
    end

    def empty_flash
        flash_types.each do |type|
            type.each { |key, value| type[key] == [] }
        end
    end

    def formatted_time(resource)
        criteria = (resource.created_at == resource.updated_at) ? "Created" : "Updated"
        resource.updated_at.strftime("#{criteria} at %I:%M%p %m/%d/%Y")
    end
    
    # No refresh required
    def paginate(resource, per_page, params)
        number_of_pages = (resource.count % per_page) > 0 ? resource.count / per_page + 1 : resource.count / per_page
        content_tag(:div, class: ['pagination', 'item-pagination']) do 
            1.upto(number_of_pages) do |i|
                concat link_to(i, query_categories_path(:category_ids => params, :page => i), method: 'POST', remote: true)
            end
        end
    end

    # Refresh required
    def paginate_buttons(category, per_page, current_page)
        current_page = current_page.to_i
        items = category.items
        number_of_pages = items.count % per_page > 0 ? items.count / per_page + 1 : items.count / per_page
        numbered_links = number_of_pages < 10 ? number_of_pages : 10 # The amount on numbered links to be dipslayed. ex: 1..10, 15..25
        max_page = ((current_page + numbered_links - 1) * per_page) <= items.count ? current_page + numbered_links - 1 : number_of_pages

        lower_limit = current_page - 5 > 1 ? current_page - 5 : 1
        upper_limit = current_page + 5 > max_page ? max_page : current_page + 5

        content_tag(:div, class: ['pagination', 'item-pagination']) do 
            concat link_to("Previous", show_category_path(category, :page => current_page - 1)) if current_page > 1
            (lower_limit).upto(upper_limit) do |i|
                concat link_to(i, show_category_path(category, :page => i))
            end
            concat link_to("Next", show_category_path(category, :page => current_page + 1)) if current_page != max_page
        end
    end 
end
