# frozen_string_literal: true

module Api
  module Samples
    class ModelDatabasesController < BaseController
      def index
        @model_databases = ::Samples::ModelDatabase.includes(:model_tables).all

        @er_diagrams = []
        @model_databases.each do |model_database|
          @er_diagrams.push load_er_diagram(model_database.name)
        end

        render 'index', formats: :json, handlers: 'jbuilder'
      end

      def show
        @model_database = ::Samples::ModelDatabase.find(params[:id])
        @er_diagram = load_er_diagram(@model_database.name)

        render 'show', formats: :json, handlers: 'jbuilder'
      end

      private

      def load_er_diagram(database)
        helpers.asset_url("er_diagrams/#{database}.png")
      end
    end
  end
end
