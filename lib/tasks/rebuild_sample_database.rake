# frozen_string_literal: true

# IMPORTANT: Always enable maintenance mode before running this task
# This ensures that users cannot access the system during the rebuild process.
namespace :rebuild do
  desc 'Rebuild sample databases'
  task :sample_database, [] => :environment do
    # Environment safety check
    if Rails.env.production?
      puts 'WARNING: This will destroy production data! Continue? (y/N)'
      input = $stdin.gets.chomp.downcase
      exit unless input == 'y'
    end

    steps = [
      { message: 'Dropping book_stores database...', task: 'db:drop:book_stores' },
      { message: 'Creating book_stores database...', task: 'db:create:book_stores' },
      { message: 'Running migrations for book_stores...', task: 'db:migrate:book_stores' },
      { message: 'Importing CSV data...', task: 'import:sample_csv_data' }
    ]

    steps.each do |step|
      puts step[:message]
      Rake::Task[step[:task]].execute
    end

    puts 'Rebuild completed successfully!'
  end
end
