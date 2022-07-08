# frozen_string_literal: true

namespace :samples do
  namespace :handle do
    desc 'handle data models'
    task :data_models, [] => :environment do
      raise 'Not allowed to run on production' if Rails.env.production?

      Rake::Task['samples:import:csv'].execute
      Rake::Task['samples:permit:table_access'].execute
      Rake::Task['samples:permit:temp_table_control'].execute
      Rake::Task['samples:register:data_models'].execute
    end
  end
end
