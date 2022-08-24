require 'rails_helper'

RSpec.describe 'Api::Admin::Works::Orders', type: :request do
  let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  before do
    allow_any_instance_of(Api::Admin::Works::OrdersController).to receive(:require_login)
    allow_any_instance_of(Api::Admin::Works::OrdersController).to receive(:check_admin)
  end

  describe 'PATCH /api/admin/works/order' do
    let(:http_request) { patch order_api_admin_works_path, params: params, headers: headers, as: :json }
    let!(:works) { create_list(:work, 3) }
    let(:params) { { ids: [[works[2].id, works[1].id, works[0].id]] } }

    it 'returns 200 status' do
      http_request
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end
end
