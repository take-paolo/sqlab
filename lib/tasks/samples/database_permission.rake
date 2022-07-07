# frozen_string_literal: true

require_relative 'rake_helpers'

namespace :samples do
  namespace :permit do
    desc 'Grant general user table access permission to each table in all model databases'
    task table_access: :environment do
      include Samples::ConnectionUser

      model_tables do |model_table|
        next if model_table.for_temp_table?

        grant_table_access_permission(model_table, general_username)
      end
    end

    desc 'Grant general user temp table control permission to each table in all model databases'
    task temp_table_control: :environment do
      include Samples::ConnectionUser

      model_databases do |model_database|
        grant_temp_table_control_permission(model_database, general_username)
      end
    end
  end
end

def grant_table_access_permission(table, user)
  table_name = table.table_name

  table.connection.execute("GRANT SELECT ON #{table_name} TO #{user}")

  puts "- Granted general user table access permission!, table => #{table_name} in #{table.current_connection_db_name}"
end

def grant_temp_table_control_permission(database, user)
  database_name = database.current_connection_db_name

  database.connection.execute("GRANT TEMP ON DATABASE #{database_name} TO #{user}")

  puts "- Granted general user temp table control permission!, database => #{database_name}"
end
