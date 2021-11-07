class Post < ApplicationRecord

  # 投稿関連のアソシエーション
  belongs_to :user
  belongs_to :genre

  attachment :post_image

  # バリデーション
  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 400}
  validates :post_image, presence: true

end
