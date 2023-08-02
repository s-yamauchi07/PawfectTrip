class Plan < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :title 
    validates :departure_date
    validates :destination_date
    validates :departure_id
    validates :destination_id
    validates :companion_id
    validates :dog_id
  end
  
end
