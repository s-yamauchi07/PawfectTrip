class Itinerary < ApplicationRecord
  belongs_to :plan

  with_options presence: true do
    validates :date
    validates :place
    validates :transportation_id, numericality: { other_than: 0, message: "must be selected"}
  end
end
