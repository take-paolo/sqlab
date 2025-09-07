require 'database_cleaner/active_record'

Rails.application.load_tasks

RSpec.configure do |config|
  config.before(:suite) do
    Rake::Task['import:sample_csv_data'].execute
  end

  # No cleanup needed since import task already clears existing records every time
end
