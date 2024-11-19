# frozen_string_literal: true

# IMPORTANT: Always enable maintenance mode before running this task
# This ensures that users cannot access the system during the rebuild process.
namespace :rebuild do
  desc 'Rebuild the book_stores database'
  task :database_book_stores, [] => :environment do
    Rails.application.eager_load!

    puts 'Dropping book_stores database...'
    Rake::Task['db:drop:book_stores'].execute

    puts 'Creating book_stores database...'
    Rake::Task['db:create:book_stores'].execute

    puts 'Running migrations for book_stores...'
    Rake::Task['db:migrate:book_stores'].execute

    puts 'Importing CSV data...'
    Rake::Task['samples:import:csv'].execute

    puts 'Rebuild completed successfully!'
  end
end
