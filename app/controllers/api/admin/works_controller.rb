# frozen_string_literal: true

module Api
  module Admin
    class WorksController < BaseController
      before_action :set_work, only: %i[update destroy]

      def index
        @works = Work.sort_by_order_number

        render 'index', formats: :json
      end

      def create
        @work = Work.new(work_params)

        if @work.save
          render 'create', formats: :json
        else
          render json: @work.errors.messages, status: :bad_request
        end
      end

      def update
        if @work.update(work_params)
          render 'update', formats: :json
        else
          render json: @work.errors.messages, status: :bad_request
        end
      end

      def update_order
        Work.update_order(params[:ids])
        head :ok
      end

      def destroy
        @work.destroy!

        head :ok
      end

      private

      def set_work
        @work = Work.find(params[:id])
      end

      def work_params
        params.require(:work).permit(:name, :slug, :description, :enabled, :published)
      end
    end
  end
end
