class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  # 通知モデルとの紐付け
  # 自分からの通知
  has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
  # 相手からの通知
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  # フォロー関連
  # 被フォロー側の関係
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 与フォロー側の関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 被フォロー関係を通じて自分をフォローしている人を参照
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 与フォロー関係を通じて自分がフォローしている人を参照
  has_many :followings, through: :relationships, source: :followed
  #フォローするアクション
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  #フォローを外すアクション
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  #フォローしているか否かの確認
  def following?(user)
    followings.include?(user)
  end
  
  # ユーザー検索機能関連
  def self.looks(search, word)
    if search == "perfect"
      @user = User.where("nickname LIKE ?", "#{word}")
    elsif search == "partial"
      @user = User.where("nickname LIKE ?", "%#{word}%")
    else
      @user = User.all
    end
  end
  
  
  # フォロー通知の作成メソッド
  def create_notification_follow!(current_user)
    # すでにフォローされているかを検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
      
  end

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
