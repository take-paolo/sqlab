# frozen_string_literal: true

require_relative 'rake_helpers'

namespace :samples do
  namespace :register do
    desc 'Register data models'
    task data_models: :environment do
      model_databases do |model_database|
        puts 'Model database:'
        database = find_model_database(model_database.database_name) || create_model_database(model_database.database_name)

        puts 'Model tables:'
        model_tables = Samples::Sorting.sort_by_associations(model_database.descendants)
        model_tables.each do |model_table|
          find_model_table(model_table.table_name) || create_model_table(database.id, model_table.table_name)
        end
      end
    end
  end
end

def find_model_database(database_name)
  database = Samples::ModelDatabase.find_by(name: database_name)
  return unless database

  puts "- found model database, id: #{database.id}, name: #{database.name}"
  database
end

def create_model_database(database_name)
  database = Samples::ModelDatabase.create!(name: database_name)
  return unless database

  puts "- created model database, id: #{database.id}, name: #{database.name}"
  database
end

def find_model_table(table_name)
  table = Samples::ModelTable.find_by(name: table_name)
  return unless table

  puts "- found model table, id: #{table.id}, name: #{table.name}"
  table
end

def create_model_table(database_id, table_name)
  table = Samples::ModelTable.create!(model_database_id: database_id, name: table_name)
  return unless table

  puts "- created model table, id: #{table.id}, name: #{table.name}"
  table
end
