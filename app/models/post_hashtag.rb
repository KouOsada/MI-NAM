class PostHashtag < ApplicationRecord

  # バリデーション
  validates :post_id, presence: true
  validates :hashtag_id, presence: true
end
