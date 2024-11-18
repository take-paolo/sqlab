require 'database_cleaner/active_record'

Rails.application.load_tasks

RSpec.configure do |config|
  config.before(:suite) do
    Rake::Task['samples:handle:data_models'].execute
  end

  config.after(:suite) do
    Samples::ModelDatabase.find_each(&:destroy)
  end
end
