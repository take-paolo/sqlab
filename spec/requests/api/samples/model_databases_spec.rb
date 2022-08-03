require 'rails_helper'

RSpec.describe 'Api::Samples::ModelDatabases', type: :request do
  let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  describe 'GET /api/samples/databases' do
    let(:http_request) { get api_samples_databases_path, headers: headers, as: :json }

    it 'returns list of works' do
      http_request
      expect(body.count).to eq Samples::ModelDatabase.all.count
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /api/samples/databases/:id' do
    let(:http_request) { get api_samples_database_path(model_database), headers: headers, as: :json }

    context 'when valid request' do
      let!(:model_database) { Samples::ModelDatabase.first }

      it 'returns database details' do
        http_request
        expect(body['id']).to eq model_database.id
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when invalid request' do
      let!(:model_database) { Samples::ModelDatabase.last }
      let(:http_request) { get api_samples_database_path(model_database.id + 1), headers: headers, as: :json }

      it 'returns 404 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
