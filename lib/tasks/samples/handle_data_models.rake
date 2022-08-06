# frozen_string_literal: true

namespace :samples do
  namespace :handle do
    desc 'handle data models'
    task :data_models, [] => :environment do
      Rake::Task['samples:import:csv'].execute
      Rake::Task['samples:register:data_models'].execute
    end
  end
end
