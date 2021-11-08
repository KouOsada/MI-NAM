class User::PostsController < ApplicationController
  include HashtagMethods
  before_action :authenticate_user!, except: [:index]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # @postのbodyからハッシュタグを抽出
    hashtag = extract_hashtag(@post.body) 
    if @post.save
      # 抽出したハッシュタグをHashtagテーブルへ、投稿idとハッシュタグidを中間テーブルへ保存
      save_hashtag(hashtag, @post)
      redirect_to post_path(@post), notice: "投稿をしました！"
    else
      render :new
    end

  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    # idのみを配列にして返す
    related_records = PostHashtag.where(post_id: @post.id).pluck(:hashtag_id)
    hashtags = Hashtag.all
    # 中間テーブルがHashtagテーブルより取得したidのハッシュタグを取得し配列にする
    @hashtags = hashtags.select{|hashtag| related_records.include?(hashtag.id)}
    # ハッシュタグが文字列のまま表示されるので、＃から始まる文字列を""に変換して表示
    @display_body = @post.body.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/,"")
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    # 中間テーブルとハッシュタグのレコードを削除するメソッド
    delete_records_related_hashtag(params[:id])
    if @post.update(post_params)
      # 更新した投稿からハッシュタグを取得
      hashtag = extract_hashtag(@post.body)
      # ハッシュタグの保存メソッド
      save_hashtag(hashtag, @post)
      redirect_to post_path(@post), notice: "内容を更新しました！"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    # 中間テーブルとハッシュタグのレコードを削除するメソッド
    delete_records_related_hashtag(params[:id])
    redirect_to posts_path, notice: "投稿を削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :post_image, :genre_id)
  end

end
