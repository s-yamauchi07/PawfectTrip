class Tag < ApplicationRecord
  has_many :plan_tags, dependent: :destroy
  has_many :plans, through: :plan_tags 
end
