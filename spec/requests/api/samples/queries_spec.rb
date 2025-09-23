require 'rails_helper'

RSpec.describe 'Api::Samples::Queries', type: :request do
  let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  describe 'POST /api/samples/databases/:database_id/sql' do
    let(:http_request) { post api_samples_query_path, params: params, headers: headers, as: :json }
    let(:params) { { sample_database_id: sample_database.id, query: query } }
    let(:sample_database) { SampleDatabaseDefinition.find_by(name: 'book_stores') }
    let(:status) { { success: 0, error: 1 } }

    context 'when valid query' do
      let(:query) { 'select * from books limit 4; select * from events;' }

      it 'returns execution result' do
        http_request
        expect(body['status']).to eq status[:success]
        expect(body['values'].count).to eq Samples::QueryParser.call(params[:query]).count
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when query is empty' do
      let(:query) { '' }

      it 'returns empty value' do
        http_request
        expect(body['status']).to eq status[:success]
        expect(body['values']).to eq ''
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when invalid database id' do
      let(:http_request) { post api_samples_query_path, params: params, headers: headers, as: :json }
      let(:params) { { sample_database_id: sample_database.id + 1, query: query } }
      let(:sample_database) { SampleDatabaseDefinition.last }
      let(:query) { '' }

      it 'returns 500 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:internal_server_error)
      end
    end

    context 'when invalid query' do
      let(:query) { 'select * into temp_books from books;' }

      it 'returns error message' do
        http_request
        expect(body['status']).to eq status[:error]
        expect(body['values']).to include 'ERROR:'
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
