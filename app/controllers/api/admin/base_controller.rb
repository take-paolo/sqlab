# frozen_string_literal: true

module Api
  module Admin
    class BaseController < ApplicationController
      include Api::ExceptionHandler

      before_action :require_login
      before_action :check_admin

      def check_admin
        head :unauthorized unless current_user.admin?
      end
    end
  end
end
