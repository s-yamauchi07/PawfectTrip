class Itinerary < ApplicationRecord
  belongs_to :plan

  with_options presence: true do
    validates :date
    validates :place
  end

  validates :transportation_id, numericality: { message: "must be selected"}
end
