# frozen_string_literal: true

module Samples
  class QueryExecutor
    attr_reader :connection

    def initialize(target_database)
      @connection = target_database.establish_connection
    end

    def all_records(tables)
      results = []

      tables.each do |table|
        result = connection.execute("select * from #{table.name} order by id asc")
        results << { name: table.name, fields: result.fields, records: result.values }
      end

      results
    end

    def execute(queries)
      results = []
      error_message = ''

      begin
        # Manually start a transaction
        connection.execute('BEGIN')

        results = execute_queries(queries)
      rescue StandardError => e
        error_message = trim_error_message(e)
      ensure
        # Always rollback to prevent changes from being persisted to the target_database
        connection.execute('ROLLBACK')
      end

      error_message.blank? ? build_response(:success, results.presence || '') : build_response(:error, error_message)
    end

    private

    STATUS_CODE = { success: 0, error: 1 }.freeze
    PG_ERROR_TYPE_REGEX = /.*(?=ERROR)/
    PG_ERROR_POINTER_REGEX = /\s+\^\n/

    def execute_queries(queries)
      results = []

      queries.each do |query|
        QueryValidator.validate(query)
        result = connection.execute(query)
        next if result.values.empty?

        results << { fields: result.fields, records: result.values }
      end

      results
    end

    def trim_error_message(error)
      error_message = remove_error_type(error.message)
      remove_error_pointer(error_message)
    end

    def remove_error_type(str)
      str.gsub(PG_ERROR_TYPE_REGEX, '')
    end

    def remove_error_pointer(str)
      str.gsub(PG_ERROR_POINTER_REGEX, '')
    end

    def build_response(status, values)
      { status: STATUS_CODE[status], values: values }
    end
  end
end
