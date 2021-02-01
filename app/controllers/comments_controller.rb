class CommentsController < ApplicationController
    def new
        @parent = Comment.find_by_id(params[:parent_id])
        @comment = Comment.new(parent_id: params[:parent_id]) if @parent
    end

    def create
        raise params.inspect
        if params[:comment][:parent_id].to_i > 0
            parent = Comment.find_by_id(params[:comment].delete(:parent_id))
            comment = parent.children.build(comment_params)
        else  
            comment = Comment.new(comment_params)
        end

        if comment.save
            redirect_to root_path
        else
            flash[:alert] = "Could not save comment"
            redirect_to item_path params[:item_id]
        end
    end
private
    def comment_params
        params.require(:comment).permit(:content, :user_id, :item_id)
    end
end