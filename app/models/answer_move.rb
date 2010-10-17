class AnswerMove < Move
  
  property :answer, String
  belongs_to :quest

  def correct_answer?
    earned_points > 0
  end

  def earned_points
    return 1000 if self.quest.correct_answer?(self.answer)
    0
  end
  
end