require 'rails_helper'

RSpec.describe 'Api::Admin::Users', type: :request do
  let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  before do
    allow_any_instance_of(Api::Admin::UsersController).to receive(:authenticate!)
    allow_any_instance_of(Api::Admin::UsersController).to receive(:check_admin)
  end

  describe 'GET /api/admin/users' do
    let(:http_request) { get api_admin_users_path, headers: headers, as: :json }
    let!(:users_num) { 3 }

    it 'returns list of users' do
      create_list(:user, users_num)
      http_request
      expect(body.count).to eq users_num
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /api/admin/users/:id' do
    let(:http_request) { delete api_admin_user_path(user.id), headers: headers, as: :json }
    let!(:user) { create(:user) }

    it 'return 200 status' do
      http_request
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end
end
