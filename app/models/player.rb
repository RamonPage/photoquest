class Player < CouchRest::Model::Base
  collection_of :moves

  def answered_quests
    self.moves.collect do |move|
      move.quest
    end 
  end 
end 
