class Admin::PostsController < ApplicationController
  include HashtagMethods
  before_action :authenticate_admin!
  
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    # 中間テーブルとハッシュタグのレコードを削除するメソッド
    delete_records_related_hashtag(params[:id])
    redirect_to admin_posts_path
  end
  
  
end
