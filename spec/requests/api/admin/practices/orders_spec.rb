require 'rails_helper'

RSpec.describe 'Api::Admin::Practices::Orders', type: :request do
  let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  before do
    allow_any_instance_of(Api::Admin::Practices::OrdersController).to receive(:require_login)
    allow_any_instance_of(Api::Admin::Practices::OrdersController).to receive(:check_admin)
  end

  describe 'PATCH /api/admin/practices/order' do
    let(:http_request) { patch order_api_admin_practices_path, params: params, headers: headers, as: :json }
    let!(:practices) { create_list(:practice, 2) }
    let!(:another_practices) { create_list(:practice, 3) }
    let(:params) { { ids: [[practices[1].id, practices[0].id], [another_practices[1].id, another_practices[2].id, another_practices[0].id]] } }

    it 'returns 200 status' do
      http_request
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end
end
