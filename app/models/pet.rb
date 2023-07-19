class Pet < ApplicationRecord
  belongs_to :user, optional: true
  
  with_options presence: true do
    validates :birthday, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: 'must be input yyyy-mm-dd' }
    with_options format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/} do
      validates :name
      validates :breed
    end
  end

  validates :size_id, numericality: { other_than: 1, message: 'must be select' }
end
