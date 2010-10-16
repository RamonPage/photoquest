# encoding: utf-8

require 'spec_helper'

describe Player do

  it "should return a list with every question he/she has already answered" do
    player = Player.find("player1")
    player.answered_quests.size.should == 2 
    player.answered_quests.should include(fetch_quest_from_move('move1'))
    player.answered_quests.should include(fetch_quest_from_move('move2'))
    player.answered_quests.should_not include(fetch_quest_from_move('move3'))
  end
end
