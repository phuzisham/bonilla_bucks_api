require 'rails_helper'

# Note `json` is a custom helper to parse JSON responses
RSpec.describe 'Account API', type: :request do
  # test data
  let!(:user) { create(:user) }
  let!(:accounts) { create_list(:account, 10, user_id: user.id) }
  let(:account_id) { accounts.first.id }
  let(:auth_headers) { user.create_new_auth_token }
  # GET /accounts
  describe 'GET /accounts' do
    # HTTP request before examples
    before { get '/accounts', headers: auth_headers }

    it 'returns accounts' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # GET /accounts/:id
  describe 'GET /accounts/:id' do
    # HTTP request before examples
    before { get "/accounts/#{account_id}", headers: auth_headers }

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

  # POST /accounts
  describe 'POST /accounts' do
    # valid payload
    let(:valid_attributes) { { balance: 174, user_id: user.id } }

    context 'when the request is valid' do
      # HTTP request before examples
      before { post '/accounts', params: valid_attributes, headers: auth_headers }

      it 'creates an account' do
        expect(json['balance']).to eq(174)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      # HTTP request before examples
      # invalid payload
      before { post '/accounts', params: { user_id: user.id  }, headers: auth_headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Balance can't be blank/)
      end
    end
  end

  # PUT /accounts/:id
  describe 'PUT /accounts/:id' do
    let(:valid_attributes) { { balance: 203, user_id: nil } }

    context 'when the record exists' do
      # HTTP request before examples
      before { put "/accounts/#{account_id}", params: valid_attributes, headers: auth_headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # DELETE /accounts/:id
  describe 'DELETE /accounts/:id' do
    # HTTP request before examples
    before { delete "/accounts/#{account_id}", headers: auth_headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
