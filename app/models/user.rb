class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable, omniauth_providers: [:google_oauth2]
  attr_accessor :current_password
         
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :size

  has_many :pets
  has_many :hotel_likes
  has_many :plan_likes
  has_many :plans, dependent: :destroy
  has_many :comments
  has_many :sns_creadentials

  validates :nickname, presence:true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ーa-zA-Z0-9]+\z/}
  
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :password, format: {with: VALID_PASSWORD_REGEX, message: "must contain both letters and at least one number."}, on: :create

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.nickname = 'GUEST'
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def self.from_omniauth(auth)
    sns = SnsCreadential.where(provider: auth.provider, uid:auth.uid).first_or_create

    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
      email: auth.info.email
    )

    # persisted？でuserが既に登録済みか確認。登録済みuserの場合はsnscredentialテーブルのuser_idカラムと紐づける。
    if user.persisted?
      sns.user = user
      sns.save
    end
    {user: user, sns: sns }
    
  end
end
