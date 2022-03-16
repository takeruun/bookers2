class RoomsController < ApplicationController
  def show
    @user = User.find(params[:user_id])
    rooms = current_user.rooms
    user_room = RoomUser.find_by(room_id: rooms.ids, user_id: @user.id)

    if user_room.nil?
      @room = Room.create()
      RoomUser.create(user_id: current_user.id, room_id: @room.id)
      RoomUser.create(user_id: @user.id, room_id: @room.id)
    else
      @room = user_room.room
    end

    @messages = @room.messages

    @message = current_user.messages.new(room_id: @room.id)
  end
end
