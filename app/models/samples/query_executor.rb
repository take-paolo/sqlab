# frozen_string_literal: true

module Samples
  class QueryExecutor
    attr_reader :connection

    def initialize(database)
      @connection = database.to_class.connection
    end

    def all_records(tables)
      results = []

      tables.each do |table|
        result = connection.execute("select * from #{table.name}")
        results << { name: table.name, fields: result.fields, records: result.values }
      end

      results
    end

    def execute(queries)
      results = []

      queries.each do |query|
        QueryValidator.validate(query)
        result = connection.execute(query)
        next if result.values.empty?

        results << { fields: result.fields, records: result.values }
      rescue StandardError => e
        return query_error(e)
      end

      format(:success, results.presence || '')
    end

    private

    STATUS_CODE = { success: 0, error: 1 }.freeze
    PG_ERROR_TYPE_REGEX = /.*(?=ERROR)/
    PG_ERROR_POINTER_REGEX = /\s+\^\n/

    def query_error(err)
      error_message = remove_error_type(err.message)
      error_message = remove_error_pointer(error_message)
      format(:error, error_message)
    end

    def remove_error_type(str)
      str.gsub(PG_ERROR_TYPE_REGEX, '')
    end

    def remove_error_pointer(str)
      str.gsub(PG_ERROR_POINTER_REGEX, '')
    end

    def format(status = :success, values = [])
      { status: STATUS_CODE[status], values: values }
    end
  end
end
