class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.save
    flash[:errors] = @comment.errors.full_messages
    if @comment.parent_comment_id.nil?
      redirect_to post_url(@comment.post)
    else
      parent = Comment.find(@comment.parent_comment_id)
      redirect_to comment_url(parent)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_url(@comment.post)
  end

  def show
    @comment = Comment.find(params[:id])
    render :show
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
