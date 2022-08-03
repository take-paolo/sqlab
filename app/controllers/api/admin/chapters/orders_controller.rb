# frozen_string_literal: true

module Api
  module Admin
    module Chapters
      class OrdersController < BaseController
        def update
          Chapter.update_order(params[:ids])

          head :ok
        end
      end
    end
  end
end
