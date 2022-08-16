require 'rails_helper'

RSpec.describe 'Api::UserSessions', type: :request do
  let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  describe 'DELETE /api/logout' do
    let!(:user) { create(:user) }
    let(:http_request) { delete api_logout_path, headers: headers }

    it 'returns 200' do
      login_as(user)
      http_request
      expect(logged_in?).to be_falsey
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end
end
