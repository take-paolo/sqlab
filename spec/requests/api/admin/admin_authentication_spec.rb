require 'rails_helper'

RSpec.describe 'Api::Admin::AdminAuthentication', type: :request do
  describe '#check_admin' do
    subject do
      get api_admin_works_path, headers: headers
      response
    end

    let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: "Bearer #{token}" } }

    context 'when request from admin user' do
      let!(:user) { create(:user, :admin) }
      let(:token) { user.create_tokens }

      it { is_expected.to have_http_status(:ok) }
    end

    context 'when request from general user' do
      let!(:user) { create(:user) }
      let(:token) { user.create_tokens }

      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
