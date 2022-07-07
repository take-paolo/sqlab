# frozen_string_literal: true

module Samples
  module Collections
    class TempMigration < ActiveRecord::Migration[6.1]
      attr_reader :table_class

      def initialize(table_class)
        super
        @table_class = table_class
      end

      def temp_up
        raise NotImplementedError
      end

      def create_table(table_name, **options)
        @connection = table_class.connection
        super
      end
    end
  end
end
