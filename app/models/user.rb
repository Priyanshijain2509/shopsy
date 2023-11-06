class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :confirmable

  after_create :send_confirmation_instructions
  before_save {email.downcase!}

  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy, foreign_key: 'seller'
  has_many :orders, class_name: 'Order', foreign_key: 'buyer'
  has_many :orders_as_seller, class_name: 'Order', foreign_key: 'seller'

  paginates_per 10
  
  VALID_CONTACTNUMBER_REGEX = /\A[6-9]\d{9}\z/
  validates :first_name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :contact_number, presence: true, length: { is: 10 },
    format: {with: VALID_CONTACTNUMBER_REGEX },
    uniqueness: true
  validates :address, presence: true
  validates :state, presence: true
  validates :pin_code, presence: true, length: { is: 6 }
  validates :role, presence: true
end
