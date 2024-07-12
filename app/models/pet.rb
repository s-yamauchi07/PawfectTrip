class Pet < ApplicationRecord
  belongs_to :user, optional: true
  
  with_options presence: true do
    validates :name, format:  { with: /\A[ぁ-んァ-ヶ一-龥々ーa-zA-Z]+\z/, message: "は全角文字または半角英字で入力してください"} 
    validates :breed, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "は全角文字で入力してください"} 
  end

  validates :size_id, numericality: {message: 'を選択してください' }
end
