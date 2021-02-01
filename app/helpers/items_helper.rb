module ItemsHelper
    def modify_options_for(item)
        if item.creator_id == current_user.id
            content_tag :div do 
                concat link_to 'edit this item', edit_item_path(item) 
                concat link_to 'delete this item', item, method: 'delete'
            end
        end 
    end

    def display_images_for(item)

    end
end

# <div class="slideshow-containter">
#     <div class="mySlides slide-fade">
#         <div class="numbertext">1 / 3</div>
#         <img src="/images/4urbof.jpg">
#         <div class="text">Caption One</div>
#     </div>
#     <div class="mySlides slide-fade">
#         <div class="numbertext">2 / 3</div>
#         <img src="/images/c.PNG">
#         <div class="text">Caption Two</div>
#     </div>
#     <div class="mySlides slide-fade">
#         <div class="numbertext">3 / 3</div>
#         <img src="/images/Cadspture.PNG">
#         <div class="text">Caption Three</div>
#     </div>
#     <a id="prev" class="prev">&#10094;</a>
#     <a id="next" class="next">&#10095;</a>
# </div>

# <div style="text-align:center">
#   <span class="dot" onclick="currentSlide(1)"></span>
#   <span class="dot" onclick="currentSlide(2)"></span>
#   <span class="dot" onclick="currentSlide(3)"></span>
# </div>