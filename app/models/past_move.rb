class PastMove < Move
  property :move , AnswerMove
  
  def initialize(move)
    self.move = move 
  end 
  def answers
    if move.correct_answer?
      [
       { :answer => self.move.correct_answer , :class => 'correct win' },
       { :answer => "Baz" , :class => nil },
       { :answer => "Whatever" , :class => nil },
       { :answer => "Whatever" , :class => nil },
       { :answer => "Whatever" , :class => nil },
      ]
    else
      [
       { :answer => self.move.correct_answer , :class => 'correct' },
       { :answer => self.move.answer , :class => 'incorrect' },
       { :answer => "Baz" , :class => nil },
       { :answer => "Whatever" , :class => nil },
       { :answer => "Whatever" , :class => nil },
      ]
    end 
  end 
end 
