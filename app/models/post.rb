class Post < ApplicationRecord
  
  # 投稿関連のアソシエーション
  belongs_to :user
  belongs_to :genre
  
  attachment :post_image
  
  # バリデーション
end
