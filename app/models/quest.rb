class Quest < CouchRest::Model::Base 

  attr_accessor :incorrect_answer1, :incorrect_answer2, :incorrect_answer3, :incorrect_answer4
  
  property :image_url, String
  property :twitter_screen_name, String
  property :twitter_image_url, String
  property :correct_answer, String
  property :incorrect_answers, [String]
  property :short_id, String

  property :abuses_reported, Integer, :default => 0 
  
  view_by :short_id
  view_by :abuses_reported
  
  validates_format_of :image_url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  validates_format_of :twitter_screen_name, :with => /^[@a-zA-Z0-9_-]{0,40}$/ix
  validates_presence_of :correct_answer, :incorrect_answer1, :incorrect_answer2, :incorrect_answer3, :incorrect_answer4 , :only => [:create]

  before_create :adapt_incorrect_answers
  before_create :strip_quest
  before_create :remove_arroba
  after_create :create_short_id
  after_create :set_twitter_image_url
  
  ALL_VALID_MAP_FUNCTION = <<MAP
  function(doc) {
    if (doc['couchrest-type'] == 'Quest') {
      if (doc.abuses_reported < 3) {
        emit(doc, doc._id);
      }
    }
  }
MAP

  QUEST_FOR_PLAYER_MAP_FUNCTION = <<MAP
  function(doc) {
    if (doc['couchrest-type'] == 'Quest') {
      if (doc.abuses_reported < 3) {
        emit(doc, doc._id);
      }
    }
  }
MAP

  REDUCE_FUNCTION = <<REDUCE
  function(key, values) {
    if (values) {
      return values[Math.floor(Math.random()*values.length)];
    }
    return null;  
  }
REDUCE
  
  view_by :all_valid, :map => ALL_VALID_MAP_FUNCTION, :reduce => REDUCE_FUNCTION
  view_by :all_quests_for_player, :map => QUEST_FOR_PLAYER_MAP_FUNCTION
  
  view_by :abuses_reported

  def mark_as_abuse!(player)
    self.abuses_reported = self.abuses_reported + 1 
    self.save
    player.create_abusive_move(self) 
  end
  
  def correct_answer?(answer)
    self.correct_answer == answer
  end

  def self.find_quest_for(player)
    return draw if player.nil? || player.answered_quests.blank?
    new_quests = Quest.by_all_valid - player.answered_quests
    new_quests.draw.first 
  end 
  
  def self.draw
    result = Quest.by_all_valid(:reduce => true)
    quest_id = result["rows"].first["value"] if result && result["rows"] && result["rows"].first && result["rows"].first["value"]
    return Quest.get(quest_id) if quest_id
    nil
  end
  
  def answers
    ([correct_answer] + incorrect_answers).shuffle
  end
  
  def create_short_id
    result = nil
    candidate = Digest::CRC32.hexdigest self.id
    if Quest.find_by_short_id(candidate)
      result = self.id
    else
      result = candidate
    end
    self.short_id = result
    save
  end
  
  def set_twitter_image_url
    if twitter_screen_name.present?
      self.twitter_image_url = get_twitter_image
      save if self.twitter_image_url
    end
  end
  
  def adapt_incorrect_answers
    if self.incorrect_answers.blank?
      self.incorrect_answers = [ incorrect_answer1.strip, 
                                 incorrect_answer2.strip, 
                                 incorrect_answer3.strip, 
                                 incorrect_answer4.strip ]
    end
  end
  
  def strip_quest
    write_attribute(:twitter_screen_name, self.twitter_screen_name.strip) unless self.twitter_screen_name.blank?
    write_attribute(:correct_answer, self.correct_answer.strip) unless self.correct_answer.blank?
  end
  
  def remove_arroba
    write_attribute(:twitter_screen_name, self.twitter_screen_name.gsub(/@/, "")) unless self.twitter_screen_name.blank?
  end
  
  private
  
  def get_twitter_image
    begin
      Timeout::timeout(5) {
        oauth = Twitter::OAuth.new TWITTER_KEYS["consumer_key"], TWITTER_KEYS["consumer_secret"]
        oauth.authorize_from_access TWITTER_KEYS["access_token"], TWITTER_KEYS["access_token_secret"]    
        client = Twitter::Base.new(oauth)
        client.user(twitter_screen_name).profile_image_url
      }
    rescue
    end
  end
end
