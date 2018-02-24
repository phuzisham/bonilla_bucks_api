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

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /accounts/:id
  describe 'GET /accounts/:id' do
    before { get "/accounts/#{account_id}" }

    context 'when the record exists' do
      it 'returns the account' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(account_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:account_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Account/)
      end
    end
  end
end
