class Pet < ApplicationRecord
  belongs_to :user, optional: true
  
  with_options presence: true do
    validates :name
    validates :breed
    validates :birthday
  end

  validates :size_id, numericality: { other_than: 1 }
end
