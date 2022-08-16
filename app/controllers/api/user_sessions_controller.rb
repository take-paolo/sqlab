# frozen_string_literal: true

module Api
  class UserSessionsController < BaseController
    before_action :require_login

    def destroy
      logout
      head :ok
    end
  end
end
