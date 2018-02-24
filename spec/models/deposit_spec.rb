require 'rails_helper'

RSpec.describe Deposit, type: :model do
  it { should belong_to(:account) }
  it {should validate_presence_of(:notes) }
  it {should validate_presence_of(:amount) }
  it {should validate_presence_of(:account_id) }
end
