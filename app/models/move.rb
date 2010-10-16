class Move < CouchRest::Model::Base
  
  property :quest_id, String
  property :answer, String
  
  def correct?
    quest = Quest.get self.quest_id
    quest.correct_answer?(self.answer)
  end
end