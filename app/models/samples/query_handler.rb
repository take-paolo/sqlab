# frozen_string_literal: true

module Samples
  class QueryHandler
    attr_reader :model_database

    def initialize(model_database)
      @model_database = model_database
    end

    def all_records(model_tables)
      TempTableCreator.create(model_tables)
      QueryExecutor.new(model_database).all_records(model_tables)
    end

    def execute(query)
      queries = QueryParser.call(query)
      TempTableCreator.create(model_database.model_tables)
      QueryExecutor.new(model_database).execute(queries)
    end
  end
end
