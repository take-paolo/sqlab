# frozen_string_literal: true

module Api
  module Admin
    module Works
      class OrdersController < BaseController
        def update
          Work.update_order(params[:ids])

          head :ok
        end
      end
    end
  end
end
