class Score
  
  def initialize(player)
    @player = player
  end
  
  def calculate
    @player.moves.select { |move| move.correct? }.count * 1000
  end
  
end