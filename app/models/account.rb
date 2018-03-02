class Account < ApplicationRecord
  belongs_to :user
  has_many :deposits, dependent: :destroy
  has_many :withdrawls, dependent: :destroy

  validates_presence_of :balance
  validates_presence_of :user_id
end
