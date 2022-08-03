# frozen_string_literal: true

require_relative 'rake_helpers'

namespace :samples do
  namespace :import do
    desc 'Import sample csv data to each table in all model databases'
    task csv: :environment do
      model_tables do |model_table|
        next if model_table.for_temp_table?

        import_csv(model_table)
      end
    end
  end
end

def import_csv(table)
  table.import_csv
  puts "- Imported sample csv data!, to => #{table.table_name} in #{table.current_connection_db_name}"
end
