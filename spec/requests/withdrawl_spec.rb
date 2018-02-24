require 'rails_helper'

RSpec.describe 'Withdrawls API', type: :request do
  # test data
  let!(:account) { create(:account) }
  let!(:withdrawls) { create_list(:withdrawl, 20, account_id: account.id) }
  let(:account_id) { account.id }
  let(:id) { withdrawls.first.id }

  # Test suite for GET /accounts/:account_id/withdrawls
  describe 'GET /accounts/:account_id/withdrawls' do
    before { get "/accounts/#{account_id}/withdrawls" }

    context 'when account exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all account withdrawls' do
        expect(json.size).to eq(20)
      end
    end

    context 'when account does not exist' do
      let(:account_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Account/)
      end
    end
  end

  # Test suite for GET /accounts/:account_id/withdrawls/:id
  describe 'GET /accounts/:account_id/withdrawls/:id' do
    before { get "/accounts/#{account_id}/withdrawls/#{id}" }

    context 'when account withdrawl exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the withdrawl' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when account withdrawl does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Withdrawl/)
      end
    end
  end

  # Test suite for PUT /accounts/:account_id/withdrawls
  describe 'POST /accounts/:account_id/withdrawls' do
    let(:valid_attributes) { { notes: 'Visit Narnia', amount: 150, account_id: account_id } }

    context 'when request attributes are valid' do
      before { post "/accounts/#{account_id}/withdrawls", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/accounts/#{account_id}/withdrawls", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Notes can't be blank, Amount can't be blank/)
      end
    end
  end

  # Test suite for PUT /accounts/:account_id/withdrawls/:id
  describe 'PUT /accounts/:account_id/withdrawls/:id' do
    let(:valid_attributes) { { notes: 'Mozart' } }

    before { put "/accounts/#{account_id}/withdrawls/#{id}", params: valid_attributes }

    context 'when withdrawl exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the withdrawl' do
        updated_withdrawl = Withdrawl.find(id)
        expect(updated_withdrawl.notes).to match(/Mozart/)
      end
    end

    context 'when the withdrawl does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Withdrawl/)
      end
    end
  end

  # Test suite for DELETE /accounts/:id
  describe 'DELETE /accounts/:id' do
    before { delete "/accounts/#{account_id}/withdrawls/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
