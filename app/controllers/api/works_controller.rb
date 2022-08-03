# frozen_string_literal: true

module Api
  class WorksController < BaseController
    def index
      @works = Work.all.published.sort_by_order_number
      render 'index', formats: :json, handlers: 'jbuilder'
    end

    def show
      @work = Work.find_by!(slug: params[:slug])

      return render_404 unless @work.enabled && @work.published

      @chapters = @work.chapters.with_practice.sort_by_order_number

      render 'show', formats: :json, handlers: 'jbuilder'
    end
  end
end
