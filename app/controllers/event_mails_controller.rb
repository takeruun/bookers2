class EventMailsController < ApplicationController
  def new
    @group = Group.find(params[:group_id])
    @event_mail = EventMail.new
  end

  def create
    @group = Group.find(params[:group_id])
    @event_mail = EventMail.new(event_mail_params)
    @event_mail.group_id = @group.id
    if @event_mail.save
      to_mails = @group.members.pluck(:email).join(',')
      EventMailMailer.send_mail(to_mails, @event_mail).deliver_now
    else
      render :new
    end
  end

  private

  def event_mail_params
    params.require(:event_mail).permit(:title, :content)
  end
end
