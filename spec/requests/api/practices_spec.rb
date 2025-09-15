require 'rails_helper'

RSpec.describe 'Api::Practices', type: :request do
  let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  describe 'GET /api/practices/:id' do
    let(:http_request) { get api_practice_path(practice), params: { with_sample_data: true }, headers: headers, as: :json }

    context 'when valid request' do
      let!(:practice) { create(:practice, :enabled, :published, :not_requires_auth) }
      let!(:sample_tables) { create_list(:sample_table, 2, practice: practice) }

      it 'returns practice detail' do
        http_request
        expect(body['id']).to eq practice.id
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when sample tables is empty' do
      let(:practice) { create(:practice, :enabled, :published, :not_requires_auth) }

      it 'returns nil' do
        http_request
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when request to disabled practice' do
      let(:practice) { create(:practice, :published, :not_requires_auth) }

      it 'returns 404 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when request to unpublished practice' do
      let(:practice) { create(:practice, :enabled, :not_requires_auth) }

      it 'returns 404 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when request to non-existent practice' do
      let!(:practice) { create(:practice) }
      let(:http_request) { get api_practice_path(practice.id + 1), headers: headers, as: :json }

      it 'returns 404 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when request with login user to practice which requires auth' do
      let!(:user) { create(:user) }
      let(:practice) { create(:practice, :enabled, :published) }

      it 'returns practice detail' do
        login_as(user)
        http_request
        expect(body['id']).to eq practice.id
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when request without login to practice which requires auth' do
      let(:practice) { create(:practice, :enabled, :published) }

      it 'returns 401 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
