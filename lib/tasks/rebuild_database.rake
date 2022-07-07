# frozen_string_literal: true

namespace :rebuild do
  desc 'rebuild all database'
  task :database, [] => :environment do
    raise 'Not allowed to run on production' if Rails.env.production?

    Rails.application.eager_load!

    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
    Rake::Task['samples:handle:data_models'].execute
    Rake::Task['db:seed'].execute
  end
end
