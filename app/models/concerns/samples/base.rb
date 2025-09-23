# frozen_string_literal: true

module Samples
  module Base
    extend ActiveSupport::Concern

    class_methods do
      delegate :import_csv, to: :bulk_insert

      def database_name
        self::DATABASE_NAME.to_s
      end

      def bulk_insert
        BulkInsert.new(self)
      end

      def temporary_table?
        SampleTableDefinition.find_by(name: table_name).temporary?
      end

      def current_connection_db_config
        connection_db_config.configuration_hash
      end

      def current_connection_db_name
        current_connection_db_config[:database]
      end

      def current_connection_username
        current_connection_db_config[:username]
      end
    end
  end
end
