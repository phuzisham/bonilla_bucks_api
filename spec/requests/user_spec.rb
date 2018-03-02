require 'rails_helper'

# Note `json` is a custom helper to parse JSON responses
RSpec.describe 'User API', type: :request do
  # test data
  let!(:user) { create(:user) }
  let(:auth_headers) { user.create_new_auth_token }
  # GET /users
  describe 'GET /users' do
    # HTTP request before examples
    before { get '/users', headers: auth_headers }

    it 'returns users' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # GET /users/:id
  describe 'GET /users/:id' do
    # HTTP request before examples
    before { get "/users/#{user_id}", headers: auth_headers }

    context 'when the record exists' do
      it 'returns the user' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find User/)
      end
    end
  end

  # POST /users
  describe 'POST /users' do
    # valid payload
    let(:valid_attributes) { { balance: 174, user_id: user.id } }

    context 'when the request is valid' do
      # HTTP request before examples
      before { post '/users', params: valid_attributes, headers: auth_headers }

      it 'creates an user' do
        expect(json['balance']).to eq(174)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      # HTTP request before examples
      # invalid payload
      before { post '/users', params: { user_id: user.id  }, headers: auth_headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Balance can't be blank/)
      end
    end
  end

  # PUT /users/:id
  describe 'PUT /users/:id' do
    let(:valid_attributes) { { balance: 203, user_id: nil } }

    context 'when the record exists' do
      # HTTP request before examples
      before { put "/users/#{user_id}", params: valid_attributes, headers: auth_headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # DELETE /users/:id
  describe 'DELETE /users/:id' do
    # HTTP request before examples
    before { delete "/users/#{user_id}", headers: auth_headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
