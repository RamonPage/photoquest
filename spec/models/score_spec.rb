# encoding: utf-8

require 'spec_helper'

describe Score do

  describe ".calculate" do
    
    before(:each) do
      @player = Player.get "player1"
      @quest1 = Quest.get "quest1"
      @quest2 = Quest.get "quest2"
    end
    
    it "should be 1000 for one correct move" do
      move = AnswerMove.create :quest => @quest1, :answer => "Chicago"
      @player.moves << move
      Score.new(@player).calculate.should == 1000
    end
    
    it "should be 2000 for two correct move on the same quest" do
      move1 = AnswerMove.create :quest => @quest1, :answer => "Chicago"
      move2 = AnswerMove.create :quest => @quest1, :answer => "Chicago"
      @player.moves << move1 << move2
      Score.new(@player).calculate.should == 2000
    end
    
    it "should be 2000 for two correct move on different quests" do
      move1 = AnswerMove.create :quest => @quest1, :answer => "Chicago"
      move2 = AnswerMove.create :quest => @quest2, :answer => "London"
      @player.moves << move1 << move2
      Score.new(@player).calculate.should == 2000
    end
    
    it "shouldn't count the wrong answers" do
      move1 = AnswerMove.create :quest => @quest1, :answer => "Chicago"
      move2 = AnswerMove.create :quest => @quest2, :answer => "San Francisco"
      @player.moves << move1 << move2
      Score.new(@player).calculate.should == 1000
    end
    
  end
  
end
