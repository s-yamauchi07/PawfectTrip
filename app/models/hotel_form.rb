class HotelForm
  include ActiveModel::Model
  attr_accessor :hotel_num, :user_id

  def save
    hotel= Hotel.find_or_create_by(hotel_num: hotel_num)
    HotelLike.create(user_id: user_id, hotel_id: hotel.id)
  end
end