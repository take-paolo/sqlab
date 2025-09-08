# frozen_string_literal: true

class SampleDatabaseDefinition < ActiveHash::Base
  include ActiveHash::Enum

  # Sample database definitions
  self.data = [
    { id: 1, name: 'book_stores' }
  ]

  enum_accessor :name

  # Get all tables for this database
  def available_tables
    SampleTableDefinition.for_database(name)
  end

  # Get all temporary tables for this database
  def available_temporary_tables
    available_tables.where(temporary: true)
  end

  # Get all permanent tables for this database
  def available_permanent_tables
    available_tables.where(temporary: false)
  end

  # Get specific tables by IDs
  def table_definitions_by_ids(table_ids)
    SampleTableDefinition.where(id: table_ids)
  end

  # Establish database connection
  def establish_connection
    record_class.connection
  end

  # Get the base record class for this database
  def record_class
    "samples/#{name}_record".classify.constantize
  end
end
