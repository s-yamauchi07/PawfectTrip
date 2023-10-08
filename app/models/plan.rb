class Plan < ApplicationRecord
  belongs_to :user
  belongs_to :pet
  has_many :itineraries, dependent: :destroy
  has_many :plan_tags, dependent: :destroy
  has_many :tags, through: :plan_tags
  has_many :plan_likes
  has_one_attached :cover_image
  accepts_nested_attributes_for :itineraries, allow_destroy: true


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :companion
  belongs_to :prefecture


  with_options presence: true do
    validates :title 
    validates :departure_date
    validates :return_date
  end
  
  with_options numericality: { other_than:1, message: "must be selected"} do
    validates :departure_id
    validates :destination_id
    validates :companion_id
  end


  def create_tags(tags)
    tags.each do |tag|
      new_tag = Tag.find_or_create_by(tag_name: tag)
      ##Plan.tagsでplanに紐づくtagsテーブルのデータにnew_tagの情報を追加する。
      self.tags << new_tag
    end
  end

  def check_image
    unless self.cover_image.attached?
      self.cover_image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'cover_image.png')), filename: 'cover-image.png', content_type: 'image/png')
    end
  end

  def like_by?(user)
    plan_likes.exists?(user_id: user.id)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["departure_id", "destination_id", "title"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["tags"]
  end
end
