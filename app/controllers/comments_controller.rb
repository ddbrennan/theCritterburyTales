class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to @comment.comic
  end

  def destroy
    @comment = Comment.find(params[:id])
    comic = @comment.comic
    @comment.delete
    redirect_to comic
  end

  private

  def comment_params
    params.require(:comment).permit(:like, :content, :comic_id)
  end

end
