class Score
  
  def initialize(player)
    @player = player
  end
  
  def calculate
    @player.moves.map(&:earned_points).sum
  end
  
end