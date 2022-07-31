# frozen_string_literal: true

module Api
  module Admin
    class BaseController < ApplicationController
      include Api::ExceptionHandler
    end
  end
end
