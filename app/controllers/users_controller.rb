class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :withdraw]
  
  def show
    @user = User.find(params[:id])
    hotel_likes = @user.hotel_likes
    @hotel_list = fetch_hotels(hotel_likes)
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_deleted: true)
    reset_session
    flash[:notice] = "退会処理が完了しました"
    redirect_to root_path
  end

  private
  def fetch_hotels(hotel_likes)
    hotels = []
    hotel_likes.each do |hotel_like|
      # API呼び出しとデータの整形を行う
      hotel_data = RakutenWebService::Travel::Hotel.search(hotelNo: Hotel.find(hotel_like.hotel_id).hotel_num, datumType: 1).first
      hotels << hotel_data
    end
    return hotels
  end

end
