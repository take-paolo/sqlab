# frozen_string_literal: true

module Api
  module Samples
    class ModelTablesController < BaseController
      def index
        model_database = ::Samples::ModelDatabase.find(params[:database_id])
        model_tables = model_database.model_tables.find(params[:table_ids])
        @model_tables_records = ::Samples::QueryHandler.new(model_database).all_records(model_tables)

        render 'index', formats: :json, handlers: 'jbuilder'
      end
    end
  end
end
