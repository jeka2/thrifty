module CommentsHelper
    def comment_roots(item_id)
        Comment.roots.where(item_id: item_id)
    end
end