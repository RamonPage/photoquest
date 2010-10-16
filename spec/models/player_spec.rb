# encoding: utf-8

require 'spec_helper'

describe Player do

  it "should return a list with every question he/she has already answered" do
    player = Player.find("player1") 
    player.answered_quests.should include(fetch_quest_from_move('move1'))
    player.answered_quests.should include(fetch_quest_from_move('move2'))
    player.answered_quests.should include(fetch_quest_from_move('move3'))
  end

  private
  def fetch_quest_from_move(move_id)
    Move.find(move_id).quest
  end 
  
end
