# frozen_string_literal: true

# user model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  before_save { email.downcase! }

  # associations
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy, foreign_key: 'seller'
  has_many :orders, class_name: 'Order', foreign_key: 'buyer'
  has_many :orders_as_seller, class_name: 'Order', foreign_key: 'seller'

  paginates_per 5

  # validations
  VALID_CONTACTNUMBER_REGEX = /\A[6-9]\d{9}\z/
  validates :first_name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 20 }
  validates :contact_number, presence: true, uniqueness: true
  validates :contact_number, length: { is: 10, message: 'must have 10 digits' }
  validates :contact_number, format: {
    with: VALID_CONTACTNUMBER_REGEX,
    message: 'must start with a digit between 6 and 9'
  }
  validates :address, presence: true
  validates :state, presence: true
  validates :pin_code, presence: true
  validates :pin_code, length: { is: 6, message: 'must have 6 digits' }
  validates :role, presence: true

  def seller?
    role == 'seller'
  end
end
