class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :confirmable

  has_many :products, dependent: :destroy
  before_save {email.downcase!}
  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 20 }
  validates :contact_number, presence: true, length: { maximum: 10 }
  validates :address, presence: true
  validates :state, presence: true
  validates :pin_code, presence: true, length: { maximum: 6 }
  validates :role, presence: true
end
