require 'rails_helper'

RSpec.describe 'Api::Sessions', type: :request do
  let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  describe 'GET /api/sessions' do
    context 'when valid request' do
      let!(:user) { create(:user) }
      let(:params) { { email: user.email, password: 'password' } }
      let(:http_request) { post api_sessions_path, params: params, headers: headers, as: :json }

      it 'returns token' do
        http_request
        expect(body).to include 'token'
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when invalid email' do
      let(:params) { { email: 'invalid_email@test.com', password: 'password' } }
      let(:http_request) { post api_sessions_path, params: params, headers: headers, as: :json }

      it 'returns 403 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'when invalid password' do
      let!(:user) { create(:user) }
      let(:params) { { email: user.email, password: 'invalid_password' } }
      let(:http_request) { post api_sessions_path, params: params, headers: headers, as: :json }

      it 'returns 403 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
