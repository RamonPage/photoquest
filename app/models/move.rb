class Move < CouchRest::Model::Base
  
  property :answer, String
  
  belongs_to :quest

  def correct?
    self.quest.correct_answer?(self.answer)
  end
end
