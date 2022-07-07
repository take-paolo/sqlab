# frozen_string_literal: true

module Samples
  module Collections
    module TempTableable
      extend ActiveSupport::Concern

      class_methods do
        delegate :temp_migrate, to: :temp_migrator

        def for_temp_table?
          true
        end

        def temp_migrator
          TempMigrator.new(self)
        end
      end
    end
  end
end
