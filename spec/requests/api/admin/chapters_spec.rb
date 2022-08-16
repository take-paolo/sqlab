require 'rails_helper'

RSpec.describe 'Api::Admin::Chapters', type: :request do
  let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  before do
    allow_any_instance_of(Api::Admin::ChaptersController).to receive(:require_login)
    allow_any_instance_of(Api::Admin::ChaptersController).to receive(:check_admin)
  end

  describe 'GET /api/admin/chapters' do
    let(:http_request) { get api_admin_chapters_path, headers: headers, as: :json }
    let!(:chapters_num) { 3 }

    it 'returns list of chapters' do
      create_list(:chapter, chapters_num)
      http_request
      expect(body.count).to eq chapters_num
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /api/admin/chapters' do
    let(:http_request) { post api_admin_chapters_path, params: params, headers: headers, as: :json }
    let!(:work) { create(:work) }

    context 'when valid request' do
      let!(:chapter) { build(:chapter, work: work) }
      let(:params) { { chapter: chapter } }

      it 'return chapter data' do
        http_request
        expect(body['name']).to eq chapter.name
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when invalid request' do
      let!(:chapter) { build(:chapter, name: '', work: work) }
      let(:params) { { chapter: chapter } }

      it 'return 400 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'PATCH /api/admin/chapters/:id' do
    let(:http_request) { patch api_admin_chapter_path(chapter.id), params: params, headers: headers, as: :json }
    let!(:chapter) { create(:chapter) }
    let(:params) { { chapter: chapter } }

    context 'when valid request' do
      it 'return chapter data' do
        chapter.name = 'test chapter'
        http_request
        expect(body['name']).to eq chapter.name
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when invalid request' do
      it 'return 400 error' do
        chapter.name = ''
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'DELETE /api/admin/chapters/:id' do
    let(:http_request) { delete api_admin_chapter_path(chapter.id), headers: headers, as: :json }
    let!(:chapter) { create(:chapter) }

    it 'return 200 status' do
      http_request
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end
end
