# frozen_string_literal: true

module Api
  module Samples
    class QueriesController < BaseController
      def execute
        target_database = SampleDatabaseDefinition.find_by(id: params[:sample_database_id])
        return render_error('Database not found') unless target_database

        @result = ::Samples::QueryHandler.new(target_database).execute(params[:query])

        render 'execute', formats: :json, handlers: 'jbuilder'
      end
    end
  end
end
