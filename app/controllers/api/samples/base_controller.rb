# frozen_string_literal: true

module Api
  module Samples
    class BaseController < ApplicationController
      include Api::ExceptionHandler
    end
  end
end
