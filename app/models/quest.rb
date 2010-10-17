class Quest < CouchRest::Model::Base
  
  attr_accessor :incorrect_answer1, :incorrect_answer2, :incorrect_answer3, :incorrect_answer4

  property :image_url, String
  property :page_where_image_is, String
  property :twitter_screen_name, String
  property :twitter_image_url, String
  property :correct_answer, String
  property :incorrect_answers, [String]
  
  before_create :adapt_incorrect_answers
  before_create :fetch_twitter_image
  
  def correct_answer?(answer)
    self.correct_answer == answer
  end

  def self.find_quest_for(player)
    return draw if player.nil? || player.answered_quests.blank?
    new_quests = all - player.answered_quests
    new_quests.draw.first 
  end 
  
  def self.draw
    Quest.all.draw.first
  end
  
  def self.first
    Quest.all.first
  end

  def answers
    ([correct_answer] + incorrect_answers).shuffle
  end
  
  def fetch_twitter_image
    if self.twitter_screen_name
      oauth = Twitter::OAuth.new TWITTER_KEYS["consumer_key"], TWITTER_KEYS["consumer_secret"]
      oauth.authorize_from_access TWITTER_KEYS["access_token"], TWITTER_KEYS["access_token_secret"]    
      client = Twitter::Base.new(oauth)
      self.twitter_image_url = client.user(twitter_screen_name).profile_image_url
    end
  end
  
  def adapt_incorrect_answers
    if self.incorrect_answers.blank?
      self.incorrect_answers = [ incorrect_answer1, 
                                 incorrect_answer2, 
                                 incorrect_answer3, 
                                 incorrect_answer4 ]
    end
  end
  
end
