class Player < CouchRest::Model::Base
  collection_of :moves

  def answered_quests
    self.moves.collect do |move|
      move.quest if move.respond_to?(:quest)
    end 
  end

  def create_sharing_move
    self.moves << SharingMove.create
    self.save
  end

  def create_answer_move(params)
    @move = AnswerMove.create(params)
    self.moves << @move
    self.save

    @move 
  end

  def create_abusive_move(quest)
    @move = AbusiveMove.create(:quest => quest)
    self.moves << @move
    self.save

    @move 
  end 
end 
