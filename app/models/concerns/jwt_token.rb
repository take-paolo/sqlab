# frozen_string_literal: true

module JwtToken
  extend ActiveSupport::Concern

  class_methods do
    def decode(encoded_token)
      decoded_jwt = JWT.decode encoded_token, SECRET_KEY, true, algorithm: 'HS256'
      decoded_jwt.first
    end
  end

  def create_tokens
    expires_in = 1.month.from_now.to_i
    payload = { user_id: id, exp: expires_in }
    encode(payload)
  end

  private

  SECRET_KEY = Rails.application.credentials.secret_key_base

  def encode(payload)
    JWT.encode payload, SECRET_KEY, 'HS256'
  end
end
