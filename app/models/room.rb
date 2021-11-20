class Room < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :notifications, dependent: :destroy
  
  # DM機能の通知メソッド
  def create_notification_dm!(current_user, message_id)
    # ルーム内の自分以外のユーザーを取得
    temp_user = Entry.where(room_id: id).where.not(user_id: current_user.id)
    # 取得したユーザーのルームを検索
    temp_room = temp_user.find_by(room_id: id)
    notification = current_user.active_notifications.new(
      room_id: id,
      message_id: message_id,
      visitor_id: current_user.id,
      visited_id: temp_room.user_id,
      action: 'dm'
    )
    # 自分のDMは通知済とする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
