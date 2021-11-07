class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end
end
