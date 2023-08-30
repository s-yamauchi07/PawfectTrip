class PlansController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @plans = Plan.page(params[:page]).per(8).order("created_at DESC")
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = Plan.new(plan_params)
    tags = params[:plan][:tag_names].split.uniq    
    @plan.create_tags(tags)
    @plan.check_image

    if @plan.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @plan = Plan.find(params[:id])
    @itineraries = Itinerary.all.group_by { |itinerary| itinerary.date}
  end

  private
 
  def plan_params
    params.require(:plan).permit(:cover_image ,:title, :departure_date, :return_date,:departure_id, :destination_id,:companion_id, :pet_id, itineraries_attributes:[:date, :place, :transportation_id,:memo]).merge(user_id: current_user.id)
  end
end
