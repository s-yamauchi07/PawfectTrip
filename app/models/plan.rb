class Plan < ApplicationRecord
  belongs_to :user
  has_many :itineraries, dependent: :destroy
  has_many :plan_tags, dependent: :destroy
  has_many :tags, through: :plan_tags
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

  def create_tags(tags)
    tags.each do |tag|
      new_tag = Tag.find_or_create_by(tag_name: tag)
      ##Plan.tagsでplanに紐づくtagsテーブルのデータにnew_tagの情報を追加する。
      self.tags << new_tag
    end
  end

end
