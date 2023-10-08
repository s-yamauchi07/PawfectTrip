class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plan

  def create
    current_user.plan_likes.create(plan_id: @plan.id)
    render turbo_stream: turbo_stream.replace(
      "plan-like",
      partial: "likes/like",
      locals: { plan: @plan }
    )
  end

  def destroy
    plan_like = current_user.plan_likes.find_by(plan_id: @plan)
    plan_like.destroy
    render turbo_stream: turbo_stream.replace(
      "plan-like",
      partial: "likes/like",
      locals: { plan: @plan }
    )
  end

  private
  def set_plan
    @plan = Plan.find(params[:plan_id])
  end
end
