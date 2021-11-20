class User::MessagesController < ApplicationController
  
  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(message_params)
      @room = Room.find(params[:message][:room_id])
      @room.create_notification_dm!(current_user, @message.id)
    end
    @messages = Message.where(room_id: @room.id)
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :room_id, :content).merge(user_id: current_user.id)
  end
  
end
