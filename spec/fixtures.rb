class Fixtures

  def self.load
    quest_from_yaml.each { |quest| Quest.create(quest) }
  end
  
  def self.reload
    setup_db
    load
  end
  
  def self.setup_db
    delete_db
    create_db
  end

  def self.delete_db
    begin
      CouchRest::Model::Base.database.delete!  
    rescue
    end
  end

  def self.create_db
    delete_db
    CouchRest::Model::Base.database.create!
  end

  private

    def self.quest_from_yaml
      fixtures = File.open("#{Rails.root}/spec/fixtures/quests.yml") 
      YAML.load(fixtures)
    end

end
