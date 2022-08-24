require 'rails_helper'

RSpec.describe 'Api::Admin::Chapters::Orders', type: :request do
  let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  before do
    allow_any_instance_of(Api::Admin::Chapters::OrdersController).to receive(:require_login)
    allow_any_instance_of(Api::Admin::Chapters::OrdersController).to receive(:check_admin)
  end

  describe 'PATCH /api/admin/chapters/order' do
    let(:http_request) { patch order_api_admin_chapters_path, params: params, headers: headers, as: :json }
    let!(:chapters) { create_list(:chapter, 2) }
    let!(:another_chapters) { create_list(:chapter, 3) }
    let(:params) { { ids: [[chapters[1].id, chapters[0].id], [another_chapters[1].id, another_chapters[2].id, another_chapters[0].id]] } }

    it 'returns 200 status' do
      http_request
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end
end
