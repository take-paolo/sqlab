require 'rails_helper'

RSpec.describe 'Api::Works', type: :request do
  let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  describe 'GET /api/works' do
    let(:http_request) { get api_works_path, headers: headers, as: :json }
    let!(:enabled_works_num) { 2 }
    let!(:disabled_works_num) { 1 }

    before do
      create_list(:work, enabled_works_num, :enabled, :published)
      create_list(:work, disabled_works_num, :published)
      create_list(:work, 10, :enabled)
    end

    it 'returns list of works' do
      http_request
      expect(body.count).to eq enabled_works_num + disabled_works_num
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /api/works/:slug' do
    let(:http_request) { get api_work_path(work.slug), headers: headers, as: :json }

    context 'when valid request' do
      let!(:enabled_practices_num) { 2 }
      let!(:disabled_practices_num) { 3 }
      let!(:work) { create(:work, :enabled, :published, :with_chapters, chapters_count: 3) }

      before do
        create_list(:practice, enabled_practices_num, :enabled, :published, chapter: work.chapters[0])
        create_list(:practice, disabled_practices_num, :published, chapter: work.chapters[1])
        create_list(:practice, 10, :enabled, chapter: work.chapters[0])
      end

      it 'returns work details' do
        http_request
        total_practices = 0
        body['chapters'].each { |chapter| total_practices += chapter['practices'].count }
        total_chapters = work.chapters.count { |chapter| chapter.practices.present? }

        expect(body['chapters'].count).to eq total_chapters
        expect(total_practices).to eq enabled_practices_num + disabled_practices_num
        expect(body['id']).to eq work.id
        expect(body.dig('chapters', 0, 'id')).to eq work.chapters[0].id
        expect(body.dig('chapters', 0, 'practices', 0, 'id')).to eq work.chapters[0].practices[0].id
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when request to disabled work' do
      let(:work) { create(:work, :published) }

      it 'returns 404 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when request to unpublished work' do
      let(:work) { create(:work, :enabled) }

      it 'returns 404 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when request to non-existent work' do
      let(:work) { build(:work, :enabled, :published) }

      it 'returns 404 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
