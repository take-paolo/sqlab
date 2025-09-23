# frozen_string_literal: true

# Rake task to import CSV data into all sample databases
namespace :import do
  desc 'Import sample csv data to each permanent table in all sample databases'
  task sample_csv_data: :environment do
    Rails.application.eager_load!

    is_top_level = Rake.application.top_level_tasks.include?('import:sample_csv_data')

    # Process each defined sample database
    SampleDatabaseDefinition.all.each do |sample_database|
      puts "[INFO] Sample database: #{sample_database.name}" unless Rails.env.test?

      # Get available permanent tables for this database
      permanent_sample_tables = sample_database.available_permanent_tables
      if permanent_sample_tables.blank?
        puts "[WARN] Sample tables not found: #{sample_database.name}" unless Rails.env.test?
        next
      end

      # Establish database connection and fetch credentials
      connection = sample_database.establish_connection
      username = sample_database.record_class.current_connection_username
      db_name = sample_database.record_class.current_connection_db_name

      # Execute all operations within a transaction for data consistency
      import_sample_data_with_transaction(connection, username, permanent_sample_tables, db_name)

      puts "[SUCCESS] Completed import for database: #{sample_database.name}"
    rescue StandardError => e
      error_msg = "Failed to import database '#{sample_database.name}': #{e.message}"

      Rails.logger.error "[import:sample_csv_data] #{error_msg}"
      Rails.logger.error e.backtrace.first(5).join("\n")

      raise StandardError, error_msg unless is_top_level

      puts "[ERROR] #{error_msg}"
    end
  end
end

# Execute CSV import operations within a database transaction
# Ensures all operations succeed or fail together (atomicity)
def import_sample_data_with_transaction(connection, username, sample_tables, db_name)
  connection.transaction do
    # Grant full privileges for import operations
    grant_all_on_sample_tables(connection, username, sample_tables)

    # Get table classes and sort by dependencies to handle foreign keys
    sample_table_classes = sample_tables.map(&:table_class)
    sorted_sample_table_classes = Samples::Sorting.sort_by_dependencies(sample_table_classes)

    puts "[INFO] Importing sample csv data into DB: #{db_name}" unless Rails.env.test?
    import_csv_for_sample_tables(sorted_sample_table_classes)

    # Restrict privileges to SELECT only after import completion
    grant_select_on_sample_tables(connection, username, sample_tables)
  end
end

# Grant ALL privileges to user on specified tables for import operations
def grant_all_on_sample_tables(connection, username, tables)
  tables.each do |table|
    # Table names and usernames are quoted for safety (prevents SQL injection)
    connection.execute("GRANT ALL ON TABLE \"#{table.name}\" TO \"#{username}\"")
    puts "[DEBUG] Granted ALL privileges to #{username} on table #{table.name}" unless Rails.env.test?
  end
end

# Revoke ALL privileges and grant only SELECT access for security
def grant_select_on_sample_tables(connection, username, tables)
  tables.each do |table|
    # First revoke all privileges, then grant only SELECT
    connection.execute("REVOKE ALL ON TABLE \"#{table.name}\" FROM \"#{username}\"")
    connection.execute("GRANT SELECT ON TABLE \"#{table.name}\" TO \"#{username}\"")
    puts "[DEBUG] Granted SELECT privilege to #{username} on table #{table.name}" unless Rails.env.test?
  end
end

# Import CSV data for each table class
def import_csv_for_sample_tables(sample_table_classes)
  sample_table_classes.each do |table_class|
    # Import CSV data using the table class's import method
    table_class.import_csv
    puts "[DONE] Imported sample csv data to: #{table_class.table_name}" unless Rails.env.test?
  end
end
