class ItinerariesController < ApplicationController
  def new
    @plan = Plan.find(params[:plan_id])
    @ininerary = Itinerary.new
  end

  def create
    @ininerary = Itinerary.new(ininerary_params)
    if @ininerary.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  private
  def ininerary_params
    params.require(:itinerary).permit(:date, :place, :transportation_id, :memo).merge(plan_id: params[:plan_id])
  end
end
