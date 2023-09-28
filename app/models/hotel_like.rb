class HotelLike < ApplicationRecord
  belongs_to :user
  belongs_to :hotel
end
