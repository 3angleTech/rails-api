namespace :threeangle do
  desc 'This is a sample job'
  task sample_job: :environment do
    puts 'Start job'
    # add operations
    puts 'End job'
  end
end
