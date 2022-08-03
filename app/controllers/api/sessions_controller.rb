# frozen_string_literal: true

module Api
  class SessionsController < BaseController
    def create
      user = User.authenticate(params[:email], params[:password])

      if user
        @token = user.create_tokens
        render 'create', formats: :json, handlers: 'jbuilder'
      else
        head :unauthorized
      end
    end
  end
end
