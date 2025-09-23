# frozen_string_literal: true

module Samples
  class TemporaryTableCreator
    attr_reader :target_database

    def initialize(target_database)
      @target_database = target_database
    end

    def create(tables)
      # Filter only temporary tables first
      temp_tables = tables.where(temporary: true)

      return if temp_tables.empty?

      # Convert temporary tables to classes
      temp_table_classes = temp_tables.map(&:table_class)

      sorted_temp_table_classes = Sorting.sort_by_dependencies(temp_table_classes)

      sorted_temp_table_classes.each do |temp_table|
        temp_table.migrate_temporary
        temp_table.import_csv
      end
    end
  end
end
