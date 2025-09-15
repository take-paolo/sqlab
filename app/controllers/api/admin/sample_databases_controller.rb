# frozen_string_literal: true

module Api
  module Admin
    class SampleDatabasesController < BaseController
      def index
        @sample_databases = SampleDatabaseDefinition.all

        render 'index', formats: :json, handlers: 'jbuilder'
      end
    end
  end
end
