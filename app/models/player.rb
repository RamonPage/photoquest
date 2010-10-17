# encoding: utf-8

class Player < CouchRest::Model::Base
  collection_of :moves
  property :last_move_id, String
  property :nick_name, String, :default => 'vinicius'
  
  SCORE_MAP_FUNCTION = <<MAP
    function(doc) {
      if (doc['couchrest-type'].match(/.*Move$/)) {
        if (doc['player_id'] != null) {
          emit(doc['player_id'], doc.earned_points)
        }
      }
    }
MAP

  RANKING_MAP_FUNCTION = <<MAP
    function(doc) {
      if (doc['couchrest-type'] == "Player") {
        emit([doc._id, doc.nick_name], 0);
      } else if (doc['couchrest-type'].match(/.*Move$/)) {
        if (doc['player_id'] != null) {
          emit([doc.player_id], doc.earned_points);
        }
      }
    }
MAP

  REDUCE_FUNCTION = <<REDUCE
    function(key, values) {
      if (values) {
        return sum(values);
      }
      return null;  
    }
REDUCE

  view_by :score, :map => SCORE_MAP_FUNCTION, :reduce => REDUCE_FUNCTION
  view_by :ranking, :map => RANKING_MAP_FUNCTION, :reduce => REDUCE_FUNCTION

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
  
  def score
    result = Player.by_score :key => self.id, :reduce => true
    return result["rows"].first["value"] if result["rows"] && result["rows"].first && result["rows"].first["value"]
    0
  end
  
  def self.ranking
    rows = Player.by_ranking(:include_docs => false, :reduce => true, :group => true, :include_docs => false, :limit => 100, :descending => true)["rows"]
    keys = rows.map { |r| r["key"].first }
    people = keys.map do |key|
      local_rows = rows.select { |row| row["key"].first == key }
      nick_name = ''
      score = 0
      local_rows.each do |local_row|
        nick_name = local_row["key"][1] if local_row["key"].size == 2
        score = local_row["value"] if local_row["key"].size < 2
      end
      { :nick_name => nick_name, :score => score }
    end.uniq
  end
  
  def last_answers
    move = Move.get self.last_move_id
    if move && move.quest
      quest = move.quest
      quest.answers.map do |answer|
        { :answer => answer, :chosen => move.answer, :correct => quest.correct_answer }
      end
    else
      []
    end
  end
end 
