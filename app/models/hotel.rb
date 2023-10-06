class Hotel < ApplicationRecord
  has_many :hotel_likes

  def liked_by?(user)
    hotel_likes.exists?(user_id: user.id)
  end
end
