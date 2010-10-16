class Quest < CouchRest::Model::Base
  
  property :image_url, String
  property :page_where_image_is, String
  property :incorrect_answers, [String]
  property :correct_answer, String
  
  def correct_answer?(answer)
    self.correct_answer == answer
  end

  def self.find_quest_for(player)
    player.answered_quests 
  end 
  
  def self.draw
    Quest.all.draw.first
  end
  
  def answers
    ([correct_answer] + incorrect_answers).shuffle
  end
  
  def self.create_from(quest_adapter)
    quest = new
    quest.image_url = quest_adapter.image_url
    quest.page_where_image_is = quest_adapter.page_where_image_is
    quest.correct_answer = quest_adapter.correct_answer
    quest.incorrect_answers = [ quest_adapter.incorrect_answer1, 
                                quest_adapter.incorrect_answer2, 
                                quest_adapter.incorrect_answer3, 
                                quest_adapter.incorrect_answer4]
    quest.save
  end
  
end
