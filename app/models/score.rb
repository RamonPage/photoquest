class Score
  
  def self.calculate
    Move.all.select { |move| move.correct? }.count * 1000
  end
  
end