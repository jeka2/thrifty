module ItemsHelper
    def modify_options_for(item)
        if item.creator_id == current_user.id
            content_tag :div do 
                concat link_to 'edit this item', edit_item_path(item) 
                concat link_to 'delete this item', item, method: 'delete'
            end
        end 
    end

    def display_image_slideshow(images)
        names = ["4urbof.jpg", "c.PNG", "Cadpture.PNG"]
        content_tag(:div, class: "slideshow-container", id: "slideshow-container") do
            names.each do |name|
                concat content_tag(:div, image_tag(name), class: ["mySlides", "slide-fade"]) 
            end
            content_tag(:div) do 
                concat content_tag(:div, "Comment")
            end
        end
    end
end
