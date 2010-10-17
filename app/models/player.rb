class Player < CouchRest::Model::Base
  collection_of :moves

  def answered_quests
    self.moves.collect do |move|
      move.quest
    end 
  end

  def create_new_move(params)
    @move = Move.create(params)
    self.moves << @move
    self.save

    @move 
  end 
end 
