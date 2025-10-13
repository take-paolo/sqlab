# frozen_string_literal: true

module Api
  module Admin
    class SampleDatabasesController < BaseController
      def index
        @sample_databases = SampleDatabaseDefinition.order(:id)

        render 'index', formats: :json
      end
    end
  end
end
