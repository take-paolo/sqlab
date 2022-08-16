# frozen_string_literal: true

require_relative 'rake_helpers'

namespace :samples do
  namespace :register do
    desc 'Register data models'
    task data_models: :environment do
      model_databases do |model_database|
        puts 'Model database:'
        database = find_or_create_model_database!(model_database.database_name)

        puts 'Model tables:'
        model_tables = Samples::Sorting.sort_by_associations(model_database.descendants)
        model_tables.each do |model_table|
          find_or_create_model_table!(database.id, model_table.table_name)
        end
      end
    end
  end
end

def find_or_create_model_database!(database_name)
  database = Samples::ModelDatabase.find_or_create_by!(name: database_name)
  puts "- id: #{database.id}, name: #{database.name}"
  database
end

def find_or_create_model_table!(database_id, table_name)
  table = Samples::ModelTable.find_or_create_by!(model_database_id: database_id, name: table_name)
  puts "- id: #{table.id}, name: #{table.name}"
end
