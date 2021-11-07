class User::HashtagsController < ApplicationController
  include HashtagMethods
  before_action :authenticate_user!
  
  def show
    @hashtag = Hashtag.find(params[:id])
    post_hashtags = PostHashtag.all
    # 中間テーブルの全レコードより、該当ハッシュタグidが含まれるものを取得し、post_idを配列に格納
    relationship_records = post_hashtags.select{ |ph| ph.hashtag_id == params[:id].to_i }.map(&:post_id)
    
    all_posts = Post.all
    # 中間テーブルの情報を含むPostレコードを取得
    @posts = all_posts.select{ |post| relationship_records.include?(post.id) }
    # 取得したレコードをハッシュに変換し、ハッシュタグをハッシュに格納する
    @post_objects = creating_structures(posts: @posts, post_hashtags: post_hashtags, hashtags: Hashtag.all)
  end
  
end
