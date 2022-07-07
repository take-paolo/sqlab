require 'rails_helper'

RSpec.describe 'Api::Samples::ModelTables', type: :request do
  let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  describe 'GET /api/samples/databases/:database_id/tables' do
    let(:http_request) { get api_samples_database_tables_path(model_database), params: params, headers: headers, as: :json }
    let!(:model_database) { Samples::ModelDatabase.first }

    context 'when valid request' do
      let!(:table_ids) { model_database.model_tables.limit(2).pluck(:id) }
      let(:params) { { tableIds: table_ids } }

      it 'returns list of sample tables records' do
        http_request
        expect(body.count).to eq table_ids.count
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when table ids is empty' do
      let(:params) { { tableIds: [] } }

      it 'returns empty array' do
        http_request
        expect(body).to eq []
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when invalid database id' do
      let(:http_request) { get api_samples_database_tables_path(model_database.id + 1), params: params, headers: headers, as: :json }
      let!(:model_database) { Samples::ModelDatabase.last }
      let(:params) { { tableIds: [] } }

      it 'returns 404 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when invalid table id' do
      let!(:table_id) { model_database.model_tables.last.id }
      let(:params) { { tableIds: [table_id + 1] } }

      it 'returns 404 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
