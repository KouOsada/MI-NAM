class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  # enumの設定
  # 　年齢　0:10代 1:20代 2:30代 3:40代 4:50代以上 
  enum age: { teen: 0, twenties: 1, thirties: 2, forties: 3, over_fifties: 4 }
  # 　肌タイプ　0:普通肌 1:乾燥肌 2:脂性肌 3:混合肌 4:敏感肌
  enum skin_type: { normal: 0, dry: 1, oily: 2, combination: 3, sensitive: 4 }
  
  attachment :profile_image
  
  # バリデーション
  validates :nickname, presence: true, length: {minimum: 2, maximun: 30}, uniqueness: true
  validates :skin_type, presence: true
  validates :introduction, length: {maximum: 100}
  
end
