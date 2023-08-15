class Plan < ApplicationRecord
  belongs_to :user
  has_many :itineraries, dependent: :destroy
  accepts_nested_attributes_for :itineraries, allow_destroy: true


  with_options presence: true do
    validates :title 
    validates :departure_date
    validates :return_date
  end
  
  with_options numericality: { other_than: 1, message: "must be selected"} do
    validates :departure_id
    validates :destination_id
    validates :companion_id
    validates :dog_id
  end

end
