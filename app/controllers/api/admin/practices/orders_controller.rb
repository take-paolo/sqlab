# frozen_string_literal: true

module Api
  module Admin
    module Practices
      class OrdersController < BaseController
        def update
          Practice.update_order(params[:ids])

          head :ok
        end
      end
    end
  end
end
