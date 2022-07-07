# frozen_string_literal: true

module Api
  class PracticesController < BaseController
    def show
      @practice = Practice.find(params[:id])

      return render_404 unless @practice.enabled && @practice.published

      render 'show', formats: :json, handlers: 'jbuilder'
    end
  end
end
