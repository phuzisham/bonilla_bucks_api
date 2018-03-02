class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :accounts
  has_many :deposits, through: :accounts
  has_many :withdrawls, through: :accounts

  validates_presence_of :name, :email, :username, :password
end
