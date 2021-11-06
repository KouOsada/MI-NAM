class Genre < ApplicationRecord
  
  has_many :posts
  
  # バリデーション
  validates :name, presence: true
  
end
