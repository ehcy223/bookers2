class User < ApplicationRecord
  has_one_attached :profile_image
  has_many :books, dependent: :destroy
  def get_profile_image(width, height)
    if profile_image.attached?
      profile_image.variant(resize_to_fill: [width, height]).processed
    else
      'default-image.webp'
    end
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if name = conditions.delete(:name)
      where(conditions).where(["lower(name) = ?", name.downcase]).first
    else
      where(conditions).first
    end
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:name] 

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, on: :create #登録時のみemail必須
end
