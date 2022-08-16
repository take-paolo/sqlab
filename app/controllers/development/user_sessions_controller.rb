# frozen_string_literal: true

module Development
  class UserSessionsController < ApplicationController
    def login_as
      user = User.find(params[:user_id])
      auto_login(user)

      head :ok
    end
  end
end
