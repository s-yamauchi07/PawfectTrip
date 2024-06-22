class PlansController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]

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
    gon.spots = @plan.itineraries
    # @planに紐づくitinerariesを日付でグループ分けする
    @itineraries = @plan.itineraries.order(:date).group_by { |itinerary| itinerary.date.strftime("%m/%d")}
    @unique_date = @itineraries.keys.group_by {|date| date}.sort
    @comment = Comment.new
    @comments = @plan.comments.includes(:user)
  end

  def edit
  end

  def update
    if @plan.update(plan_params)
      redirect_to plan_path(@plan)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @plan.destroy
      flash[:notice] = '日程の削除が完了しました'
    end
    redirect_to root_path
  end

  def search
    @q = Plan.ransack(params[:q])
    @plans = @q.result(distinct: true)
  end

  private
 
  def plan_params
    params.require(:plan).permit(:cover_image ,:title, :departure_date, :return_date,:departure_id, :destination_id,:companion_id, :pet_id, itineraries_attributes:[:id, 
      
      :date, :place, :transportation_id, :memo, :lat, :lng, :_destroy]).merge(user_id: current_user.id)
  end

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def check_user
    if current_user != @plan.user
      redirect_to root_path
    end
  end
end
