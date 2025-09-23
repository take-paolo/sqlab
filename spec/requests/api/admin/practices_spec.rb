require 'rails_helper'

RSpec.describe 'Api::Admin::Practices', type: :request do
  let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  before do
    allow_any_instance_of(Api::Admin::PracticesController).to receive(:require_login)
    allow_any_instance_of(Api::Admin::PracticesController).to receive(:check_admin)
  end

  describe 'GET /api/admin/practices' do
    let(:http_request) { get api_admin_practices_path, headers: headers, as: :json }
    let!(:practices_num) { 3 }

    it 'returns list of practices' do
      create_list(:practice, practices_num)
      http_request
      expect(body.count).to eq practices_num
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /api/admin/practices' do
    let(:http_request) { post api_admin_practices_path, params: params, headers: headers, as: :json }
    let!(:chapter) { create(:chapter) }

    context 'when valid request' do
      let!(:practice) { create(:practice, chapter: chapter) }
      let(:params) { { practice: practice, sampleTables: [1, 2, 3] } }

      before do
        create(:sample_table, practice: practice, uid: 1)
        create(:sample_table, practice: practice, uid: 2)
        create(:sample_table, practice: practice, uid: 3)
      end

      it 'return practice data' do
        http_request
        expect(body['name']).to eq practice.name
        expect(body['sampleTableIds']).to contain_exactly(1, 2, 3)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when invalid request' do
      let!(:practice) { build(:practice, name: '', chapter: chapter) }
      let(:params) { { practice: practice } }

      it 'return 400 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PATCH /api/admin/practices/:id' do
    let(:http_request) { patch api_admin_practice_path(practice.id), params: params, headers: headers, as: :json }
    let!(:practice) { create(:practice) }
    let(:params) { { practice: practice, sampleTables: [1, 2] } }

    before do
      create(:sample_table, practice: practice, uid: 1)
      create(:sample_table, practice: practice, uid: 2)
    end

    context 'when valid request' do
      it 'return practice data' do
        practice.name = 'test practice'
        http_request
        expect(body['name']).to eq practice.name
        expect(body['sampleTableIds']).to contain_exactly(1, 2)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when invalid request' do
      it 'return 400 error' do
        practice.name = ''
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:bad_request)
      end
    end
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

  describe 'DELETE /api/admin/practices/:id' do
    let(:http_request) { delete api_admin_practice_path(practice.id), headers: headers, as: :json }
    let!(:practice) { create(:practice) }

    it 'return 200 status' do
      http_request
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end
end
