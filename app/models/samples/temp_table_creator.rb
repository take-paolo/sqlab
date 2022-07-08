# frozen_string_literal: true

module Samples
  class TempTableCreator
    def self.create(tables)
      tables = tables.map(&:to_class)

      temp_tables = tables.filter(&:for_temp_table?)

      return if temp_tables.empty?

      temp_tables = Sorting.sort_by_associations(temp_tables)

      temp_tables.each do |temp_table|
        temp_table.temp_migrate
        temp_table.import_csv
      end
    end
  end
end
