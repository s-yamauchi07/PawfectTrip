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
    gon.spots = @plan.itineraries
    # @planに紐づくitinerariesを日付でグループ分けする
    @itineraries = @plan.itineraries.all.group_by { |itinerary| itinerary.date.strftime("%m/%d")}
    @unique_date = @itineraries.keys.group_by {|date| date}.uniq
  end

  private
 
  def plan_params
    params.require(:plan).permit(:cover_image ,:title, :departure_date, :return_date,:departure_id, :destination_id,:companion_id, :pet_id, itineraries_attributes:[:date, :place, :transportation_id, :memo, :lat, :lng]).merge(user_id: current_user.id)
  end
end
