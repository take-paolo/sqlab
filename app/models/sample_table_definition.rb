# frozen_string_literal: true

class SampleTableDefinition < ActiveHash::Base
  # Sample table definitions with database association
  self.data = [
    # book_stores database tables
    { id: 1, name: 'authors', temporary: false, database_id: 1 },
    { id: 2, name: 'books', temporary: false, database_id: 1 },
    { id: 3, name: 'stores', temporary: false, database_id: 1 },
    { id: 4, name: 'book_sales', temporary: false, database_id: 1 },
    { id: 5, name: 'events', temporary: true, database_id: 1 },
    { id: 6, name: 'categories', temporary: false, database_id: 1 },
    { id: 7, name: 'book_authors', temporary: false, database_id: 1 },
    { id: 8, name: 'book_categories', temporary: false, database_id: 1 }
  ]

  # Check if table is temporary
  def temporary?
    temporary
  end

  # Get the database this table belongs to
  def database
    @database ||= SampleDatabaseDefinition.find_by(id: database_id)
  end

  # Get the ActiveRecord class for this table
  def table_class
    "samples/#{database.name}/#{name}".classify.constantize
  end

  class << self
    # Get tables for a specific database by name
    def for_database(database_name)
      database = SampleDatabaseDefinition.find_by(name: database_name)
      return [] unless database

      where(database_id: database.id)
    end
  end
end
