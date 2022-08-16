# frozen_string_literal: true

require_relative 'rake_helpers'

namespace :samples do
  namespace :import do
    desc 'Import sample csv data to each table in all model databases'
    task csv: :environment do
      model_databases do |model_database|
        return puts 'No target.' if model_database.descendants.empty?

        grant_all_permissions(model_database)

        model_tables = Samples::Sorting.sort_by_associations(model_database.descendants)
        model_tables.each do |model_table|
          next if model_table.for_temp_table?

          import_csv(model_table)
        end

        grant_select_permission(model_database)
      end
    end
  end
end

def grant_all_permissions(database)
  database.connection.execute("GRANT All ON All TABLES IN SCHEMA public TO #{database.current_connection_username}")
end

def grant_select_permission(database)
  database.connection.execute("
    REVOKE All ON All TABLES IN SCHEMA public FROM #{database.current_connection_username};
    GRANT SELECT ON All TABLES IN SCHEMA public TO #{database.current_connection_username};
  ")
end

def import_csv(table)
  table.import_csv
  puts "- Imported sample csv data!, to => #{table.table_name} in #{table.current_connection_db_name}"
end
