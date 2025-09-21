# frozen_string_literal: true

module Api
  module Admin
    class ChaptersController < BaseController
      before_action :set_chapter, only: %i[update destroy]

      def index
        @chapters = Chapter.sort_by_order_number

        render 'index', formats: :json, handlers: 'jbuilder'
      end

      def create
        @chapter = Chapter.new(chapter_params)

        if @chapter.save
          render 'create', formats: :json, handlers: 'jbuilder'
        else
          render json: @chapter.errors.messages, status: :bad_request
        end
      end

      def update
        if @chapter.update(chapter_params)
          render 'update', formats: :json, handlers: 'jbuilder'
        else
          render json: @chapter.errors.messages, status: :bad_request
        end
      end

      def update_order
        Chapter.update_order(params[:ids])
        head :ok
      end

      def destroy
        @chapter.destroy!

        head :ok
      end

      private

      def set_chapter
        @chapter = Chapter.find(params[:id])
      end

      def chapter_params
        params.require(:chapter).permit(:work_id, :name)
      end
    end
  end
end
