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

  describe "retrieving the last move done by this player" do
    it "should return nil when there is no move done" do
      @player = Player.new
      @player.last_move.should be_nil
    end

    it "should return the last move done" do 
      @player = Player.new
      @player.create_answer_move 
      @player.last_move.should_not be_nil
      
      player_retrieved = Player.find(@player.id)
      player_retrieved.last_move.should_not be_nil
    end
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

    context "when it is a abusive move" do

      it "should save this user" do
        @player.should_receive(:save)
        @player.create_abusive_move(mock_quest) 
      end

      it { proc { @player.create_abusive_move(mock_quest) }.should change(@player.moves, :size).by(1) }
    end 
  end 
end
