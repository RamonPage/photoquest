class Quest < CouchRest::Model::Base 
  
  attr_accessor :incorrect_answer1, :incorrect_answer2, :incorrect_answer3, :incorrect_answer4

  property :image_url, String
  property :page_where_image_is, String
  property :twitter_screen_name, String
  property :twitter_image_url, String
  property :correct_answer, String
  property :incorrect_answers, [String]
  property :short_id, String

  property :abuses_reported, Integer, :default => 0 
  
  view_by :short_id
  validates_presence_of :image_url, :page_where_image_is, :correct_answer, :incorrect_answer1, :incorrect_answer2, :incorrect_answer3, :incorrect_answer4
  
  before_create :adapt_incorrect_answers
  after_create :create_short_id

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
  
  def twitter_image_url
    # if read_attribute('twitter_image_url').blank?
    #       if twitter_screen_name.present?
    #         begin
    #           Timeout::timeout(5) {
    #             oauth = Twitter::OAuth.new TWITTER_KEYS["consumer_key"], TWITTER_KEYS["consumer_secret"]
    #             oauth.authorize_from_access TWITTER_KEYS["access_token"], TWITTER_KEYS["access_token_secret"]    
    #             client = Twitter::Base.new(oauth)
    #             write_attribute('twitter_image_url', client.user(twitter_screen_name).profile_image_url)
    #            self.save
    #           }
    #         rescue
    #         end
    #       end
    #     end
    #     read_attribute('twitter_image_url')
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
