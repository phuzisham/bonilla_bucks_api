require 'rails_helper'

# Note `json` is a custom helper to parse JSON responses
RSpec.describe 'Account API', type: :request do
  FactoryBot.find_definitions
  # test data
  let!(:accounts) { create_list(:account, 10) }
  let(:account_id) { accounts.first.id }

  # GET /accounts
  describe 'GET /accounts' do
    # HTTP request before examples
    before { get '/accounts' }

    it 'returns accounts' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end
  end
end
