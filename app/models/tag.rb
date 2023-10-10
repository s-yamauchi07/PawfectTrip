class Tag < ApplicationRecord
  has_many :plan_tags, dependent: :destroy
  has_many :plans, through: :plan_tags

  validates :tag_name, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["tag_name"]
  end
end
