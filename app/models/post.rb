class Post < ApplicationRecord

  # アソシエーション
  belongs_to :user
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  #いいねしているかの確認メソッド
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # 投稿の検索機能関連
  def self.looks(search, word)
    if search == "perfect"
      @post = Post.where(["title LIKE ? OR body LIKE ?", "#{word}", "#{word}"])
      # OR hashtag LIKE ?
    elsif search == "partial"
      @post = Post.where(["title LIKE ? OR body LIKE ?", "%#{word}%", "%#{word}%"])
    else
      @post = Post.all
    end
  end
  
  # いいねを通知するメソッド
  def create_notification_like!(current_user)
    # すでにいいねされているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねは通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  # コメントを通知するメソッド
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人を全て取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end
  
  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントは通知済とする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  attachment :post_image

  # バリデーション
  validates :title, presence: true
  validates :body, presence: true, length: {maximum: 400}
  validates :post_image, presence: true

end
