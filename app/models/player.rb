class Player < CouchRest::Model::Base
  collection_of :moves

  def answered_quests
    self.moves.collect do |move|
      move.quest if move.respond_to?(:quest)
    end 
  end

  def create_new_move(params)
    @move = AnswerMove.create(params)
    self.moves << @move
    self.save

    @move 
  end 
end 
