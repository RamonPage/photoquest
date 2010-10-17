class Quest < CouchRest::Model::Base
  
  attr_accessor :incorrect_answer1, :incorrect_answer2, :incorrect_answer3, :incorrect_answer4

  property :image_url, String
  property :page_where_image_is, String
  property :correct_answer, String
  property :incorrect_answers, [String]
  
  before_create :adapt_incorrect_answers
  
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
  
  def adapt_incorrect_answers
    if self.incorrect_answers.blank?
      self.incorrect_answers = [ incorrect_answer1, 
                                 incorrect_answer2, 
                                 incorrect_answer3, 
                                 incorrect_answer4 ]
    end
  end
  
end
