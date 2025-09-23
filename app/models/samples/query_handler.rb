# frozen_string_literal: true

module Samples
  class QueryHandler
    attr_reader :target_database

    def initialize(target_database)
      @target_database = target_database
    end

    def all_records(tables)
      TemporaryTableCreator.new(target_database).create(tables)
      QueryExecutor.new(target_database).all_records(tables)
    end

    def execute(query)
      queries = QueryParser.call(query)
      temporary_tables = target_database.available_temporary_tables
      TemporaryTableCreator.new(target_database).create(temporary_tables)
      QueryExecutor.new(target_database).execute(queries)
    end
  end
end
