require 'rails_helper'

RSpec.describe 'Api::Authentication', type: :request do
  describe '#authenticate!' do
    subject do
      get api_practice_path(practice), headers: headers
      response
    end

    let!(:user) { create(:user) }
    let!(:token) { user.create_tokens }
    let!(:practice) { create(:practice, :enabled, :published) }
    let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: "Bearer #{token}" } }

    context 'when valid token' do
      it { is_expected.to have_http_status(:ok) }
    end

    context 'when invalid token' do
      let(:token) { 'invalid token' }

      it { is_expected.to have_http_status(:unauthorized) }
    end

    context 'when expired token' do
      let!(:payload) { { user_id: user.id, exp: 1.month.ago.to_i } }
      let(:token) { JWT.encode payload, Rails.application.credentials.secret_key_base, 'HS256' }

      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
