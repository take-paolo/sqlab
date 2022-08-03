# frozen_string_literal: true

module Api
  module Admin
    class BaseController < ApplicationController
      include Api::ExceptionHandler
      include Api::UserAuthenticator

      before_action :authenticate!
      before_action :check_admin

      def check_admin
        head :unauthorized unless current_user.admin?
      end
    end
  end
end
