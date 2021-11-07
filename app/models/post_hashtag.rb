class PostHashtag < ApplicationRecord
  
  # バリデーション
  validates :post_id, presence: true
  validates :hashtags_id, presence: true
end
