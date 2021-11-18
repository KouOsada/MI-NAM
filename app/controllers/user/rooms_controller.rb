class User::RoomsController < ApplicationController
  
  def create
    @room = Room.create
    @entry1 = Entry.create(user_id: current_user.id, room_id: @room.id)
    @entry2 = Entry.create(room_params)
    redirect_to room_path(@room.id, user_id: @entry2.user_id)
  end
  
  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.massages.includes(:user)
      @message = Message.new
      @entries = @room.entries
      @user = User.find(params[:user_id])
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  def room_params
    params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
  end
end
