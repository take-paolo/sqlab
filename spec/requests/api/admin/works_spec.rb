require 'rails_helper'

RSpec.describe 'Api::Admin::Works', type: :request do
  let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  before do
    allow_any_instance_of(Api::Admin::WorksController).to receive(:require_login)
    allow_any_instance_of(Api::Admin::WorksController).to receive(:check_admin)
  end

  describe 'GET /api/admin/works' do
    let(:http_request) { get api_admin_works_path, headers: headers, as: :json }
    let!(:works_num) { 3 }

    it 'returns list of works' do
      create_list(:work, works_num)
      http_request
      expect(body.count).to eq works_num
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /api/admin/works' do
    let(:http_request) { post api_admin_works_path, params: params, headers: headers, as: :json }

    context 'when valid request' do
      let!(:work) { build(:work) }
      let(:params) { { work: work } }

      it 'return work data' do
        http_request
        expect(body['name']).to eq work.name
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when invalid request' do
      let!(:work) { build(:work, name: '') }
      let(:params) { { work: work } }

      it 'return 400 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PATCH /api/admin/works/:id' do
    let(:http_request) { patch api_admin_work_path(work.id), params: params, headers: headers, as: :json }
    let!(:work) { create(:work) }
    let(:params) { { work: work } }

    context 'when valid request' do
      it 'return work data' do
        work.name = 'test work'
        http_request
        expect(body['name']).to eq work.name
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when invalid request' do
      it 'return 400 error' do
        work.name = ''
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:bad_request)
      end
    end
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

  describe 'DELETE /api/admin/works/:id' do
    let(:http_request) { delete api_admin_work_path(work.id), headers: headers, as: :json }
    let!(:work) { create(:work) }

    it 'return 200 status' do
      http_request
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end
end
