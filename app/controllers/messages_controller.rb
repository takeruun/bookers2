class MessagesController < ApplicationController
  def create
    room = Room.find(params[:room_id])
    message = Message.new(message_params)
    message.user_id = current_user.id
    message.room_id = room.id
    message.save

    redirect_to user_rooms_path(room)
  end

  private

  def message_params
    params.require(:message).permit(:message)
  end
end
