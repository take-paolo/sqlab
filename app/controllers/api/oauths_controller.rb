# frozen_string_literal: true

module Api
  class OauthsController < BaseController
    def oauth
      login_at(auth_params[:provider])
    end

    def callback
      provider = auth_params[:provider]
      @user = login_from(provider)

      unless @user
        @user = create_from(provider)
        reset_session
        auto_login(@user)
      end

      redirect_to root_path
    end

    private

    def auth_params
      params.permit(:code, :provider)
    end
  end
end
