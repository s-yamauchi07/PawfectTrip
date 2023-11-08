class CommentsChannel < ApplicationCable::Channel
  def subscribed
    @plan = Plan.find(params[:plan_id])
    stream_from "comments_chanel_#{@plan.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
