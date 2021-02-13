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

    def paginate(resource, per_page, params)
        number_of_pages = (resource.count % per_page) > 0 ? resource.count / per_page + 1 : resource.count / per_page
        content_tag(:div, class: ['pagination', 'item-pagination']) do 
            1.upto(number_of_pages) do |i|
                concat link_to(i, query_categories_path(:category_ids => params, :page => i), method: 'POST', remote: true)
            end
        end
    end
end
