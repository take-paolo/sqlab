require 'database_cleaner/active_record'

Rails.application.load_tasks

RSpec.configure do |config|
  config.before(:suite) do
    Rake::Task['samples:handle:data_models'].execute
  end

  config.after(:suite) do
    Samples::ModelDatabase.all.each do |model_database|
      model_database.to_class.establish_connection model_database.name.to_sym
      model_database.destroy
      DatabaseCleaner[:active_record, db: model_database.name.to_sym].strategy = :truncation
      DatabaseCleaner[:active_record, db: model_database.name.to_sym].clean
    end
  end
end
