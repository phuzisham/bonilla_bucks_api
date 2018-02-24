class Deposit < ApplicationRecord
  belongs_to :account

  validates_presence_of :notes, :amount, :account_id
end
