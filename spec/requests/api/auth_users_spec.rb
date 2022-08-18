require 'rails_helper'

RSpec.describe 'Api::AuthUsers', type: :request do
  let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  describe 'GET /api/auth_user' do
    let(:http_request) { get api_auth_user_path, headers: headers }

    context 'when user is logged in' do
      let!(:user) { create(:user) }

      it 'returns current user' do
        login_as(user)
        http_request
        expect(logged_in?).to be_truthy
        expect(body['id']).to eq current_user.id
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is not logged in' do
      it 'returns nil' do
        http_request
        expect(logged_in?).to be_falsey
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'PATCH /api/auth_user' do
    let!(:user) { create(:user) }
    let(:http_request) { patch api_auth_user_path, params: user, headers: headers, as: :json }
    let(:params) { { user: user } }

    before do
      login_as(user)
    end

    context 'when valid request' do
      it 'returns updated current user' do
        user.name = 'test user'
        http_request
        expect(body['name']).to eq user.name
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when invalid request' do
      it 'returns 400 error' do
        user.name = ''
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE /api/auth_user' do
    let!(:user) { create(:user) }
    let(:http_request) { delete api_auth_user_path, headers: headers }

    it 'returns 200' do
      login_as(user)
      http_request
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end
end
