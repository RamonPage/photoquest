# encoding: utf-8

class Player < CouchRest::Model::Base
  collection_of :moves
  property :last_move_id, String

  def create_quest(params)
    @quest = Quest.create(params)
    self.create_sharing_move

    @quest 
  end 
  def answered_quests
    self.moves.collect do |move|
      move.quest if move.respond_to?(:quest)
    end 
  end

  def quest_from_last_move
    Quest.get(self.last_move[:quest_id]) if self.last_move.present? 
  end

  def answer_from_last_move
    self.last_move[:answer] if self.last_move.present? 
  end 

  def create_sharing_move
    self.moves << SharingMove.create(:player => self)
    self.save
  end

  def create_answer_move(params={})
    @move = AnswerMove.create(params.merge(:player => self))
    self.moves << @move
    self.last_move_id = @move.id
    self.save

    @move 
  end

  def create_abusive_move(quest)
    @move = AbusiveMove.create(:quest => quest, :player => self)
    self.moves << @move
    self.save

    @move 
  end 
  
  def last_answers
    move = Move.get self.last_move_id
    quest = move.quest
    quest.answers.map do |answer|
      { :answer => answer, :chosen => move.answer, :correct => quest.correct_answer }
    end
  end
end 
