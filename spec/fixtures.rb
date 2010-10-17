class Fixtures

  def self.load
    load_model(Quest)
    load_model(AnswerMove, "answer_move")
    load_model(Player)
  end
  
  def self.load_model(klass, filename = klass.to_s.downcase)
    from_yaml(filename).each { |object| klass.create(object) }
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
  
  def self.dump_quests
    File.open("#{Rails.root}/spec/fixtures/quests_dumped.yml", 'w') do |file|
      YAML.dump(Quest.all, file)
    end
  end

  private
  
    def self.from_yaml(filename)
      fixtures = File.open("#{Rails.root}/spec/fixtures/#{filename}.yml")
      YAML.load(fixtures)
    end

end
