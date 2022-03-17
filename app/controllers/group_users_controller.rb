class GroupUsersController < ApplicationController
  def create
    current_user.group_users.create(group_id: params[:group_id])

    redirect_to group_path(params[:group_id])
  end

  def destroy
    current_user.group_users.find_by(group_id: params[:group_id]).destroy

    redirect_to group_path(params[:group_id])
  end
end
