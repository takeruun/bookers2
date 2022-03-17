class EventMailsController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @event_mail = EventMail.new
  end

  def create
    @event_mail = EventMail.new(event_mail_params)
    @event_mail.group_id = params[:group_id]
    @event_mail.save
  end

  private

  def event_mail_params
    params.require(:event_mail).permit(:title, :content)
  end
end
