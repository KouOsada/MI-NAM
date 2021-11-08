class Comment < ApplicationRecord
  
  #アソシエーション
  belongs_to :user
  belongs_to :post
  
  validates :comment, presence: true, length: {maximum: 150}
  
end
