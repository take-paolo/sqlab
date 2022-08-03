# frozen_string_literal: true

module Samples
  module Collections
    class TempMigrator
      attr_reader :table_class, :migration_filename

      def initialize(table_class)
        @table_class = table_class
        @migration_filename = parse_migration_filename(table_class.table_name)
      end

      def temp_migrate
        load_migration
        exec_migration
      end

      private

      TEMP_MIGRATION_DIR = 'db/temp'

      def parse_migration_filename(table_name)
        "create_#{table_name}"
      end

      def load_migration
        migration_path = load_migration_path
        ensure_migration_file_exist(migration_path)
        require migration_path
      end

      def load_migration_path
        Rails.root.join("#{TEMP_MIGRATION_DIR}/#{table_class.database_name}/#{migration_filename}.rb")
      end

      def ensure_migration_file_exist(file)
        return if File.exist?(file)

        raise LoadError, "No such migration file or directory, file path => #{file}"
      end

      def exec_migration
        migration_class = migration_filename.camelize.constantize
        migration_class.new(table_class).temp_up
      end
    end
  end
end
