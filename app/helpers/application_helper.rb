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
    
    def paginate(resource, per_page, category_ids)
        number_of_pages = (resource.count % per_page) > 0 ? resource.count / per_page + 1 : resource.count / per_page
        content_tag(:div, class: ['pagination', 'item-pagination']) do 
            1.upto(number_of_pages) do |i|
                concat link_to(i, query_categories_path(:item => { :category_ids => category_ids }, :page => i), method: 'POST', remote: true)
            end
        end
    end

    # Page refreshes happen or not  depending on the type of request
    # If the search needs to be refined on a page foreign to the item, the whole
    # page shouldn't be refreshed. For example, if looking up items of a particular user
    # on the user's page, the whole page shouldn't reload if the items are filtered
    def paginate_buttons(resources, per_page, current_page, type_hash, query=nil, remote=false)
        current_page = current_page.to_i
        request_params = get_params(type_hash, query)

        number_of_pages = resources.count % per_page > 0 ? resources.count / per_page + 1 : resources.count / per_page
        numbered_links = number_of_pages < 10 ? number_of_pages : 10 # The amount on numbered links to be dipslayed. ex: 1..10, 15..25
        max_page = ((current_page + numbered_links - 1) * per_page) <= resources.count ? current_page + numbered_links - 1 : number_of_pages

        lower_limit = current_page - 5 > 1 ? current_page - 5 : 1
        upper_limit = current_page + 5 > max_page ? max_page : current_page + 5

        content_tag(:div, class: ['pagination', 'item-pagination']) do 
            request_params[:options][:page] = current_page - 1
            concat link_to("Previous", Rails.application.routes.url_helpers.send(request_params[:path], request_params[:options]), method: request_params[:request_type], remote: remote) if current_page > 1

            (lower_limit).upto(upper_limit) do |i|
                request_params[:options][:page] = i
                concat link_to(i, Rails.application.routes.url_helpers.send(request_params[:path], request_params[:options]), method: request_params[:request_type], remote: remote)
            end

            request_params[:options][:page] = current_page + 1
            concat link_to("Next", Rails.application.routes.url_helpers.send(request_params[:path], request_params[:options]), method: request_params[:request_type], remote: remote) if current_page != max_page
        end
    end 
protected
    def get_params(type_hash, query)
        type = type_hash.keys.first
        if type == :user
            { path: 'query_items_path',
              options: { 
                    :user_id => type_hash[type],
                    :q => query
                },
              request_type: :post    
            }
        elsif type == :category
            binding.pry
            { path: 'category_path',
              options: {
                    :id => type_hash[type]
              }  
            }
        end
    end
end
