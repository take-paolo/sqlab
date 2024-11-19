# frozen_string_literal: true

module Api
  class OauthsController < BaseController
    def oauth
      login_at(auth_params[:provider])
    end

    def callback
      provider = auth_params[:provider]

      return redirect_to root_path if access_denied?

      if (@user = login_from(provider))
        redirect_to root_path
      else
        begin
          @user = create_from(provider)
          reset_session
          auto_login(@user)
          redirect_to root_path
        rescue StandardError
          redirect_to root_path
        end
      end
    end

    private

    def auth_params
      params.permit(:code, :provider, :error)
    end

    def access_denied?
      return false unless auth_params[:error]

      auth_params[:error].match?('access_denied')
    end
  end
end
