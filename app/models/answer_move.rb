class AnswerMove < Move
  
  property :answer, String
  belongs_to :quest
  
  before_create :set_earned_points

  def correct_answer?
    self.earned_points > 0
  end

  def correct_answer
    self.quest.correct_answer 
  end 

  def set_earned_points
    write_attribute("earned_points", earned_points_value)
  end

  def quest
    return Quest.get(self.quest_id) if self.quest_id
  end
  
  private
  
  def earned_points_value
    return 1000 if self.quest && self.quest.correct_answer?(self.answer)
    0
  end
  
end
