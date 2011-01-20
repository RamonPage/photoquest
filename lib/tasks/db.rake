require Rails.root.to_s + "/spec/fixtures"

namespace :db do
  namespace :fixtures do
    desc "Initialize the database with some dummy items"
    task :reload => :environment do
      Fixtures.reload
    end
  end

  namespace :fixtures do
    desc "Dump quests from DB"
    task :dump_quests => :environment do
      Fixtures.dump_quests
    end
  end

  desc "Load the seed data from db/seeds.rb"
  task :seed => :environment do
    seed_file = File.join(Rails.root, 'db', 'seeds.rb')
    puts seed_file
    load(seed_file) if File.exist?(seed_file)
    puts "Done."
  end

  desc "Delete and recreate the database"
  task :setup => :environment do
    Fixtures.setup_db
  end
end
