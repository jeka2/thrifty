module ItemsHelper
    def modify_options_for(item)
        if item.creator_id == current_user.id
            content_tag :div do 
                concat link_to 'edit this item', edit_item_path(item) 
                concat link_to 'delete this item', item, method: 'delete'
            end
        end 
    end

    def display_image_slideshow(item)
        images = item.images
        path_urls = Array.new
        if !item.images.empty?
            path_split_arr = images.first.identifier.split('"')
            path_split_arr.each.with_index do |val, i|
                path_urls << val if i % 2 != 0
            end
            path = item.id
        else
            path_urls << "default.jpg"
            path = "fallback"
        end
        
        render partial: 'items/slideshow', locals: { images: path_urls, path: path }
    end
end

# <div id="slideshow-container" class="slideshow-containter">
#     <div class="mySlides slide-fade">
#         <div class="numbertext">1 / 3</div>
#         <%= image_tag "4urbof.jpg" %>
#     </div>
#     <div class="mySlides slide-fade">
#         <div class="numbertext">2 / 3</div>
#         <%= image_tag("c.PNG") %>
#     </div>
#     <div class="mySlides slide-fade">
#         <div class="numbertext">3 / 3</div>
#         <%= image_tag("Cadpture.PNG") %>
#     </div>
#     <div style="width: 100%;">
#         <a id="prev" class="prev">&#10094;</a>
#         <a id="next" class="next">&#10095;</a>
#     </div>
#     <div id="dots-container" style="text-align:center">
#         <span class="dot"></span>
#         <span class="dot"></span>
#         <span class="dot"></span>
#     </div>
# </div>