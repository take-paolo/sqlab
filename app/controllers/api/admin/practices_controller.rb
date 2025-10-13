# frozen_string_literal: true

module Api
  module Admin
    class PracticesController < BaseController
      before_action :set_practice, only: %i[update destroy]

      def index
        @practices = Practice.includes(:sample_tables).sort_by_order_number

        render 'index', formats: :json
      end

      def create
        @practice = Practice.new(practice_params)

        @practice.transaction do
          @practice.save!

          sample_table_ids.each do |id|
            @practice.sample_tables.create!(uid: id)
          end
        end
        render 'create', formats: :json
      rescue ActiveRecord::RecordInvalid => e
        render json: e.record.errors.messages, status: :bad_request
      end

      def update
        @practice.transaction do
          @practice.update_with_sample_tables!(practice_params, sample_table_ids)
        end
        @practice.sample_tables.reload
        render 'update', formats: :json
      rescue ActiveRecord::RecordInvalid => e
        render json: e.record.errors.messages, status: :bad_request
      end

      def update_order
        Practice.update_order(params[:ids])
        head :ok
      end

      def destroy
        @practice.destroy!

        head :ok
      end

      private

      def set_practice
        @practice = Practice.find(params[:id])
      end

      def practice_params
        params.require(:practice).permit(:chapter_id, :name, :question, :answer, :sample_database_id, :display_er_diagram, :enabled, :published, :requires_auth)
      end

      def sample_table_ids
        params[:sample_tables] || []
      end
    end
  end
end
