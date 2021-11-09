class Post < ApplicationRecord

  # アソシエーション
  belongs_to :user
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  #お気に入りにしているかの確認メソッド
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # 投稿の検索機能関連
  def self.looks(search, word)
    if search == "perfect"
      @post = Post.where(["title LIKE ? OR body LIKE ?", "#{word}", "#{word}"])
      # OR hashtag LIKE ?
    elsif search == "partial"
      @post = Post.where(["title LIKE ? OR body LIKE ?", "%#{word}%", "%#{word}%"])
    else
      @post = Post.all
    end
  end

  attachment :post_image

  # バリデーション
  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 400}
  validates :post_image, presence: true

end
