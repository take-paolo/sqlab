# frozen_string_literal: true

module Samples
  class BulkInsert
    require 'csv'

    attr_reader :table_class, :csv_file_path

    def initialize(table_class)
      @table_class = table_class
      @csv_file_path = locate_csv_file
    end

    def import_csv
      csv_records = []
      clear_existing_records

      CSV.foreach(csv_file_path, headers: true) do |row|
        csv_records << table_class.new(row.to_hash)
      end

      table_class.import!(csv_records)
    end

    private

    CSV_DATA_DIR = 'db/csv'

    def locate_csv_file
      csv_file_path = build_csv_file_path
      ensure_csv_file_exists(csv_file_path)
      csv_file_path
    end

    def build_csv_file_path
      Rails.root.join("#{CSV_DATA_DIR}/#{table_class.database_name}/#{table_class.table_name}.csv")
    end

    def ensure_csv_file_exists(file_path)
      return if File.exist?(file_path)

      raise LoadError, "CSV file not found: #{file_path}"
    end

    def clear_existing_records
      table_class.destroy_all if table_class.exists?
    end
  end
end
