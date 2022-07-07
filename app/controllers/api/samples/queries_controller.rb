# frozen_string_literal: true

module Api
  module Samples
    class QueriesController < BaseController
      def index
        model_database = ::Samples::ModelDatabase.find(params[:database_id])
        @result = ::Samples::QueryHandler.new(model_database).execute(params[:query])

        render 'index', formats: :json, handlers: 'jbuilder'
      end
    end
  end
end
