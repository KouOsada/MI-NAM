class User::CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @post = Post.find(params[:post_id])
    comment = current_user.comments.new(comment_params)
    comment.post_id = @post.id
    comment.save
    # コメントの通知
    @post.create_notification_comment!(current_user, comment.id)
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    Comment.find_by(id: params[:id]).destroy
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:comment)
  end
  
end
