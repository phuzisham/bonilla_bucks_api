require 'rails_helper'

RSpec.describe Account, type: :model do
  it { should have_many(:deposits).dependent(:destroy) }
  it { should have_many(:withdrawls).dependent(:destroy) }
  it { should validate_presence_of(:balance) }
  it { should validate_presence_of(:user_id) }
end
