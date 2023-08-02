class PlansController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    if @plan.save
      render :create, status: :unprocessable_entity
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def plan_params
    params.require(:plan).permit(:title, :departure_date, :return_date,:departure_id, :destination_id,:companion_id, :dog_id).merge(user_id: current_user.id)
  end
end
