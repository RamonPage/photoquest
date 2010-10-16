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
  
  desc "Delete and recreate the database"
  task :setup => :environment do
    Fixtures.setup_db
  end
end
