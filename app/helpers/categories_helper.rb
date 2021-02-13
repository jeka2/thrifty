module CategoriesHelper
    def paginate(resource, per_page, params)
        number_of_pages = (resource.count % per_page) > 0 ? resource.count / per_page + 1 : resource.count / per_page
        content_tag(:div, class: ['pagination', 'item-pagination']) do 
            1.upto(number_of_pages) do |i|
                concat link_to(i, query_categories_path(:category_ids => params, :page => i), method: 'POST', remote: true)
            end
        end
    end
end