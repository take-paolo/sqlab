# frozen_string_literal: true

module Api
  class AuthUsersController < BaseController
    before_action :require_login, only: %i[update destroy]

    def show
      render 'show', formats: :json, handlers: 'jbuilder'
    end

    def update
      if current_user.update(auth_user_params)
        render 'update', formats: :json, handlers: 'jbuilder'
      else
        render json: current_user.errors.messages, status: :bad_request
      end
    end

    def destroy
      current_user.destroy!

      head :ok
    end

    private

    def auth_user_params
      params.require(:auth_user).permit(:name, :email)
    end
  end
end
