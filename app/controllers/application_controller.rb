# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :snakeize_params

  def snakeize_params
    params.deep_transform_keys!(&:underscore)
  end
end
