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

  describe "creation of a new move" do

    before do
      @params = { :quest_id => '1', :answer => 'Portland' }
      @player = Player.new
    end
    it 'should create a new move' do
      proc { @player.create_answer_move(@params) }.should change(AnswerMove, :count).by(1)
    end

    it 'should add the created move to this players moves' do
      proc { @player.create_answer_move(@params) }.should change(@player.moves, :size).by(1) 
    end

    it "should return the created move" do
      @move = @player.create_answer_move(@params)
      @move.id.should_not be_nil
      @move.quest_id.should_not be_nil
      @move.answer.should  == 'Portland' 
    end 
  end 
end
