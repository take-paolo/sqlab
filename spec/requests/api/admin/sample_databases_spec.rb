require 'rails_helper'

RSpec.describe 'Api::Admin::SampleDatabases', type: :request do
  let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  before do
    allow_any_instance_of(Api::Admin::SampleDatabasesController).to receive(:require_login)
    allow_any_instance_of(Api::Admin::SampleDatabasesController).to receive(:check_admin)
  end

  describe 'GET api/admin/sample_databases' do
    let(:http_request) { get api_admin_sample_databases_path, headers: headers, as: :json }

    it 'returns list of sample databases' do
      http_request
      expect(body[0]['name']).to eq SampleDatabaseDefinition.first.name
      expect(body[0]['tables'].pluck('name')).to eq SampleDatabaseDefinition.first.available_tables.pluck(:name)
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end
end
