# frozen_string_literal: true

module Samples
  module Collections
    class BulkInsert
      require 'csv'

      attr_reader :table_class, :csv_path

      def initialize(table_class)
        @table_class = table_class
        @csv_path = find_csv
      end

      def import_csv
        records = []
        delete_all_records

        CSV.foreach(csv_path, headers: true) do |row|
          records << table_class.new(row.to_hash)
        end

        table_class.import!(records)
      end

      private

      CSV_DIR = 'db/csv'

      def find_csv
        csv_path = load_csv_path
        ensure_csv_file_exist(csv_path)
        csv_path
      end

      def load_csv_path
        Rails.root.join("#{CSV_DIR}/#{table_class.database_name}/#{table_class.table_name}.csv")
      end

      def ensure_csv_file_exist(file)
        return if File.exist?(file)

        raise LoadError, "No such csv file or directory, file path => #{file}"
      end

      def delete_all_records
        table_class.destroy_all if table_class.exists?
      end
    end
  end
end
