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

  attachment :post_image

  # バリデーション
  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 400}
  validates :post_image, presence: true

end
