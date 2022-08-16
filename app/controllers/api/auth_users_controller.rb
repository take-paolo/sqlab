# frozen_string_literal: true

module Api
  class AuthUsersController < BaseController
    def show
      render 'show', formats: :json, handlers: 'jbuilder'
    end
  end
end
