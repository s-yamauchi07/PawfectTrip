class Pet < ApplicationRecord
  belongs_to :user, optional: true
  
  with_options presence: true do
    validates :birthday, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: 'must be input yyyy-mm-dd' }

    validates :name, format:  { with: /\A[ぁ-んァ-ヶ一-龥々ーa-zA-Z]+\z/} 
    validates :breed, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/} 
  end

  validates :size_id, numericality: {message: 'must be select' }
end
