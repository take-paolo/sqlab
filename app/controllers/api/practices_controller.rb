# frozen_string_literal: true

module Api
  class PracticesController < BaseController
    def show
      @practice = Practice.find(params[:id])
      @with_sample_data = params[:with_sample_data] == 'true'

      return render_404 unless available_practice?
      return head :unauthorized unless accessible_practice?

      fetch_sample_data if @with_sample_data

      render 'show', formats: :json, handlers: 'jbuilder'
    end

    private

    # Check if practice is enabled and published
    def available_practice?
      @practice.enabled && @practice.published
    end

    # Check if current user can access this practice
    def accessible_practice?
      !@practice.requires_auth || current_user
    end

    # Fetch all sample data needed for the practice
    def fetch_sample_data
      target_database = SampleDatabaseDefinition.find_by(id: @practice.sample_database_id)

      return unless target_database

      @er_diagram_url = fetch_er_diagram_url(target_database)
      @sample_table_data = fetch_sample_table_data(target_database)
    end

    # Get ER diagram URL if display is enabled for the practice
    def fetch_er_diagram_url(target_database)
      return nil unless @practice.display_er_diagram

      helpers.asset_url("er_diagrams/#{target_database.name}.png")
    end

    # Fetch sample table records for the practice tables
    def fetch_sample_table_data(target_database)
      sample_tables = @practice.sample_tables

      return [] if sample_tables.blank?

      # Convert sample table UIDs to table definitions
      sample_table_ids = sample_tables.pluck(:uid)
      sample_table_definitions = target_database.table_definitions_by_ids(sample_table_ids)

      # Force evaluation of ActiveHash::Relation for downstream processing
      return [] if sample_table_definitions.blank?

      # Fetch all records for sample tables
      ::Samples::QueryHandler.new(target_database).all_records(sample_table_definitions)
    end
  end
end
