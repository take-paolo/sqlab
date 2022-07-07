# frozen_string_literal: true

def model_databases
  Rails.application.eager_load!

  Samples::DataModelsRecord.descendants.select(&:abstract_class?).each do |model_database|
    puts "#{model_database}:"
    yield model_database
  end
end

def model_tables(&block)
  model_databases do |model_database|
    return puts 'No target.' if model_database.descendants.empty?

    model_tables = Samples::Sorting.sort_by_associations(model_database.descendants)
    model_tables.each(&block)
  end
end
