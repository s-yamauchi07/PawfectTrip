class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence:true

  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :password, format: {with: VALID_PASSWORD_REGEX, message: "must contain both letters and at least one number."}

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.nickname = 'GUEST'
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
