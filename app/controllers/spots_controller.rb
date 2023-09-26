class SpotsController < ApplicationController
  def show
    hotel = RakutenWebService::Travel::Hotel.search(hotelNo: params[:id]).first
    @hotel_info = hotel["hotelBasicInfo"]
    @hotel_rating = hotel["hotelRatingInfo"]
  end

  def search_hotel
    gon.application_id = ENV["RAKUTEN_APPLICATION_ID"]
  end
end
