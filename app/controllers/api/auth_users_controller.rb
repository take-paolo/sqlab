# frozen_string_literal: true

module Api
  class AuthUsersController < BaseController
    include Api::UserAuthenticator
    before_action :authenticate!

    def show
      render 'show', formats: :json, handlers: 'jbuilder'
    end
  end
end
