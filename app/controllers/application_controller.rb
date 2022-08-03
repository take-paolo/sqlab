# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  before_action :snakeize_params

  def snakeize_params
    params.deep_transform_keys!(&:underscore)
  end
end
