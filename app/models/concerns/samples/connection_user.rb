# frozen_string_literal: true

module Samples
  module ConnectionUser
    extend ActiveSupport::Concern

    DATABASE_CONFIG = Rails.configuration.database_configuration

    def general_user
      DATABASE_CONFIG['general_user'].values
    end

    def general_username
      DATABASE_CONFIG['general_user']['username']
    end
  end
end
