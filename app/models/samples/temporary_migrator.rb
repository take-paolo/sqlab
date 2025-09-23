# frozen_string_literal: true

module Samples
  class TemporaryMigrator
    attr_reader :table_class

    def initialize(table_class)
      @table_class = table_class
    end

    def migrate_temporary
      load_migration_file
      execute_migration
    end

    private

    def migration_filename
      "create_#{table_class.table_name}"
    end

    def temporary_migration_dir
      "#{table_class.database_name}_migrate_temporary"
    end

    def load_migration_file
      migration_file_path = build_migration_file_path
      ensure_migration_file_exists(migration_file_path)
      require migration_file_path
    end

    def build_migration_file_path
      Rails.root.join("db/#{temporary_migration_dir}/#{migration_filename}.rb")
    end

    def ensure_migration_file_exists(file_path)
      return if File.exist?(file_path)

      raise LoadError, "Migration file not found: #{file_path}"
    end

    def execute_migration
      migration_class = migration_filename.camelize.constantize
      migration_class.new(table_class).create_temporary_table
    end
  end
end
