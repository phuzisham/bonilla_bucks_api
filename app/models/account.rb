class Account < ApplicationRecord
  belongs_to :user
  has_many :deposits, dependent: :destroy
  has_many :withdrawls, dependent: :destroy

  validates_presence_of :balance
  # !!! add user_id validation after model is created !!!
end
