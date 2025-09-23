require 'rails_helper'

RSpec.describe 'Api::Practices', type: :request do
  let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  describe 'GET /api/practices/:id' do
    let(:http_request) { get api_practice_path(practice), params: { with_sample_data: 'true' }, headers: headers, as: :json }

    context 'when valid request' do
      let!(:practice) { create(:practice, :enabled, :published, :not_requires_auth, sample_database_id: sample_database_definition_book_stores.id) }
      let(:sample_database_definition_book_stores) { SampleDatabaseDefinition.find_by(name: 'book_stores') }
      let(:sample_table_definition_books) { SampleTableDefinition.find_by(name: 'books') }
      let(:sample_table_definition_authors) { SampleTableDefinition.find_by(name: 'authors') }

      before do
        create(:sample_table, practice: practice, uid: sample_table_definition_books.id)
        create(:sample_table, practice: practice, uid: sample_table_definition_authors.id)
      end

      it 'returns practice detail' do
        http_request
        expect(body['id']).to eq practice.id
        expect(body['question']).to eq practice.question
        expect(body['answer']).to eq practice.answer
        expect(body['sampleDatabaseId']).to eq practice.sample_database_id
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end

      it 'returns ER diagram URL and sample table data' do
        http_request
        # Check ER diagram URL
        expect(body['erDiagramUrl']).to include('er_diagrams/book_stores-')
        # Check sample table data
        sample_table_data = body['sampleTableData'].map do |sample_table|
          { name: sample_table['name'], fields: sample_table['fields'], total_records: sample_table['records'].count }
        end
        expect(sample_table_data.pluck(:name)).to contain_exactly(
          sample_table_definition_books.name,
          sample_table_definition_authors.name
        )
        expect(sample_table_data.pluck(:fields)).to contain_exactly(
          sample_table_definition_books.table_class.column_names,
          sample_table_definition_authors.table_class.column_names
        )
        expect(sample_table_data.pluck(:total_records)).to contain_exactly(
          sample_table_definition_books.table_class.count,
          sample_table_definition_authors.table_class.count
        )
      end
    end

    context 'when sample tables are empty' do
      let(:practice) { create(:practice, :enabled, :published, :not_requires_auth) }

      it 'returns empty sample data array' do
        http_request
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
        expect(body['sampleTableData']).to eq []
      end
    end

    context 'when ER diagram is hidden' do
      let(:practice) { create(:practice, :enabled, :published, :not_requires_auth, :hidden_er_diagram) }

      it 'ER diagram URL is nil' do
        http_request
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
        expect(body['erDiagramUrl']).to be_nil
      end
    end

    context 'when requesting disabled practice' do
      let(:practice) { create(:practice, :published, :not_requires_auth) }

      it 'returns 404 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when requesting unpublished practice' do
      let(:practice) { create(:practice, :enabled, :not_requires_auth) }

      it 'returns 404 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when requesting non-existent practice' do
      let!(:practice) { create(:practice) }
      let(:http_request) { get api_practice_path(practice.id + 1), headers: headers, as: :json }

      it 'returns 404 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when requesting with logged-in user for practice that requires auth' do
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

    context 'when requesting without login for practice that requires auth' do
      let(:practice) { create(:practice, :enabled, :published) }

      it 'returns 401 error' do
        http_request
        expect(response).not_to be_successful
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
