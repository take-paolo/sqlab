# frozen_string_literal: true

module Api
  module Admin
    class UsersController < BaseController
      def index
        @users = User.all

        render 'index', formats: :json
      end

      def destroy
        user = User.find(params[:id])
        user.destroy!

        head :ok
      end
    end
  end
end
