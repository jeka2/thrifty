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
end
