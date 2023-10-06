class HotelsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def show
    hotel = RakutenWebService::Travel::Hotel.search(hotelNo: params[:id], datumType: 1).first
    @hotel_info = hotel["hotelBasicInfo"]
    @hotel_rating = hotel["hotelRatingInfo"]
    @hotel_num = params[:id]
    @hotel_record = Hotel.find_by(hotel_num: @hotel_num)

    gon.hotel = @hotel_info
  end

  def create
    @hotelform = HotelForm.new(form_params)
    @hotel_num = params[:hotel_num]
    if @hotelform.valid?
      @hotelform.save
      @hotel_record = Hotel.find_by(hotel_num: @hotel_num)
      render turbo_stream: turbo_stream.replace(
        "like-btn",
        partial: "hotels/like",
        locals: { hotel_record: @hotel_record, hotel_num: @hotel_num}
      )
    end
  end

  def destroy
    @hotel_record  = Hotel.find(params[:id])
    @hotel_num = @hotel_record.hotel_num
    hotel_like = current_user.hotel_likes.find_by(hotel_id: @hotel_record.id)
    hotel_like.destroy

    render turbo_stream: turbo_stream.replace(
      "like-btn",
      partial: "hotels/like",
      locals: { hotel_record: @hotel_record, hotel_num: @hotel_num}
    )
  end

  def search
    gon.application_id = ENV["RAKUTEN_APPLICATION_ID"]
  end

  private
  def form_params
    params.permit(:hotel_num).merge(user_id: current_user.id)
  end

end
