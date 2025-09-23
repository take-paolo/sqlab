# frozen_string_literal: true

module Samples
  class TemporaryMigration < ActiveRecord::Migration[6.1]
    attr_reader :table_class

    def initialize(table_class)
      super
      @table_class = table_class
    end

    def create_temporary_table
      raise NotImplementedError
    end

    def create_table(table_name, **options)
      @connection = table_class.connection
      super
    end
  end
end
