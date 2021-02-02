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
        resource.updated_at.strftime("#{criteria} at %I:%M%p %m/%d/%Y#")
    end
end
