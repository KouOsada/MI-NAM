class PostHashtag < ApplicationRecord
  
  #お気に入りにしているかの確認メソッド
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # バリデーション
  validates :post_id, presence: true
  validates :hashtag_id, presence: true
end
