# frozen_string_literal: true

module Samples
  module TemporaryTableable
    extend ActiveSupport::Concern

    class_methods do
      delegate :migrate_temporary, to: :temporary_migrator

      def temporary_migrator
        TemporaryMigrator.new(self)
      end
    end
  end
end
