# frozen_string_literal: true

module Api
  module Admin
    class WorksController < BaseController
      before_action :set_work, only: %i[update destroy]

      def index
        @works = Work.all.sort_by_order_number

        render 'index', formats: :json, handlers: 'jbuilder'
      end

      def create
        @work = Work.new(work_params)

        if @work.save
          render 'create', formats: :json, handlers: 'jbuilder'
        else
          render json: @work.errors.messages, status: :bad_request
        end
      end

      def update
        if @work.update(work_params)
          render 'update', formats: :json, handlers: 'jbuilder'
        else
          render json: @work.errors.messages, status: :bad_request
        end
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
