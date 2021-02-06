module ApplicationHelper
    def display_flash
        if flash[:alert] && !flash[:alert].empty?
            content_tag(:ul, class: 'errors') do 
                flash[:alert].each do |mssg|
                    concat content_tag(:li, mssg, class: 'error')
                end
            end
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
