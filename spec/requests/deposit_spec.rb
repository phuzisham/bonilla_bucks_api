require 'rails_helper'

RSpec.describe 'Deposits API', type: :request do
  # test data
  let!(:account) { create(:account) }
  let!(:deposits) { create_list(:deposit, 20, account_id: account.id) }
  let(:account_id) { account.id }
  let(:id) { deposits.first.id }

  # Test suite for GET /accounts/:account_id/deposits
  describe 'GET /accounts/:account_id/deposits' do
    before { get "/accounts/#{account_id}/deposits" }

    context 'when account exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all account deposits' do
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

  # Test suite for GET /accounts/:account_id/deposits/:id
  describe 'GET /accounts/:account_id/deposits/:id' do
    before { get "/accounts/#{account_id}/deposits/#{id}" }

    context 'when account deposit exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the deposit' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when account deposit does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Deposit/)
      end
    end
  end

  # Test suite for PUT /accounts/:account_id/deposits
  describe 'POST /accounts/:account_id/deposits' do
    let(:valid_attributes) { { notes: 'Visit Narnia', amount: 150, account_id: account_id } }

    context 'when request attributes are valid' do
      before { post "/accounts/#{account_id}/deposits", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/accounts/#{account_id}/deposits", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Notes can't be blank, Amount can't be blank/)
      end
    end
  end

  # Test suite for PUT /accounts/:account_id/deposits/:id
  describe 'PUT /accounts/:account_id/deposits/:id' do
    let(:valid_attributes) { { notes: 'Mozart' } }

    before { put "/accounts/#{account_id}/deposits/#{id}", params: valid_attributes }

    context 'when deposit exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the deposit' do
        updated_deposit = Deposit.find(id)
        expect(updated_deposit.notes).to match(/Mozart/)
      end
    end

    context 'when the deposit does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Deposit/)
      end
    end
  end

  # Test suite for DELETE /accounts/:id
  describe 'DELETE /accounts/:id' do
    before { delete "/accounts/#{account_id}/deposits/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
