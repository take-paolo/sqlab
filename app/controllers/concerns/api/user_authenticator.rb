# frozen_string_literal: true

module Api
  module UserAuthenticator
    def authenticate!
      return if current_user

      head :unauthorized
    end

    def current_user
      return @current_user if @current_user
      return unless bearer_token

      payload = User.decode bearer_token
      @current_user ||= User.find_by(id: payload['user_id'])
    rescue JWT::ExpiredSignature, JWT::DecodeError
      nil
    end

    def bearer_token
      pattern = /^Bearer /
      header = request.headers['Authorization']

      header.gsub(pattern, '') if header&.match(pattern)
    end
  end
end
