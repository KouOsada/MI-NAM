module User::NotificationsHelper

  # 未確認通知の検索
  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end

end
