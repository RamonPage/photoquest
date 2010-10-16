class Quest < CouchRest::Model::Base
  
  property :image_url, String
  property :page_where_image_is, String
  property :questions, [String]
  property :answer, String
  
  def correct_answer?(answer)
    self.answer == answer
  end
  
  def self.draw
    Quest.all.draw.first
  end
  
  def self.create_from(quest_adapter)
    quest = new
    quest.image_url = quest_adapter.image_url
    quest.page_where_image_is = quest_adapter.page_where_image_is
    quest.answer = quest_adapter.correct_answer
    quest.questions = [ quest_adapter.wrong_answer1, 
                        quest_adapter.wrong_answer2, 
                        quest_adapter.wrong_answer3, 
                        quest_adapter.wrong_answer4]
    quest.save
  end
  
end