# frozen_string_literal: true

module Samples
  class Sorting
    # Sorts database tables by their dependency relationships to ensure proper creation order
    # Tables with foreign key constraints will be ordered after their referenced tables
    def self.sort_by_dependencies(tables, result = [])
      tables_copy ||= Array.new(tables)
      return result if tables_copy.blank?

      # Process the next table in queue
      current_table = tables_copy.shift
      # Get all belongs_to associations (foreign key dependencies)
      belongs_to_relations = current_table.reflect_on_all_associations(:belongs_to)
      # Find dependencies that haven't been processed yet
      unresolved_dependencies = belongs_to_relations.map(&:table_name) & tables_copy.map(&:table_name)

      if belongs_to_relations.present? && unresolved_dependencies.present?
        # Table has unresolved dependencies - move to end of queue for later processing
        tables_copy << current_table
        current_table = nil
      end

      # Add table to result if it can be processed now (no unresolved dependencies)
      result << current_table if current_table.present?
      # Recursively process remaining tables
      sort_by_dependencies(tables_copy, result)
    end
  end
end
