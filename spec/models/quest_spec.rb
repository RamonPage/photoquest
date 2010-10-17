# encoding: utf-8

require 'spec_helper'

class Array
  
  def shuffle
    self
  end
  
end

describe Quest do
  
  describe "properties" do
    
    it "should have the expected properties" do
      quest = Quest.first
      quest.image_url.should ==  "http://farm4.static.flickr.com/3081/2558637383_d8a797b758_o.jpg"
      quest.page_where_image_is = "http://www.flickr.com/photos/viniciusteles/2558637383/in/set-72157605484089896/"
      quest.twitter_screen_name.should == "rafaeldx7"
      quest.answers.should == %w(Chicago Portland Rio Paris London)
      quest.correct_answer.should == "Chicago"
      quest.incorrect_answers.should == %w(Portland  Rio Paris London)
      quest.correct_answer?("Portland").should be_false
      quest.correct_answer?("Chicago").should be_true
    end
    
  end
  
  describe ".find_quest_for" do
    
    before(:each) do
      @quest = Quest.all.last
      Quest.stub!(:draw).and_return(@quest)
    end
    
    it "should draw a new quest when player isn't present" do
      Quest.find_quest_for(nil).should == @quest
    end
    
    it "should draw a new quest when player didn't answer any quest so far" do
      Quest.find_quest_for(Player.new).should == @quest
    end
    
    it "should draw a quest from the ones the user didn't answer yet" do
      player = Player.get "player4"
      quest4 = Quest.get "quest4"
      Quest.find_quest_for(player).should == quest4
    end
    
    it "should be nil when player has answered all quests available" do
      player = Player.get "player5"
      Quest.find_quest_for(player).should be_nil
    end
    
  end
  

  describe "finding a quest that a given player has not yet answered" do
    it "should return the first quest available for a new player" do
      Quest.stub!(:draw).and_return([])
      Quest.find_quest_for(nil).should == []
    end 

    it 'should fetch his list of already answered questions' do
      player = mock_model(Player).as_null_object
      player.should_receive(:answered_quests)
      Quest.find_quest_for(player) 
    end

    it "should retrieve a quest that the player hasn't answered yet" do
      player = Player.find("player1")
      player.answered_quests.should_not include(Quest.find_quest_for(player))
      Quest.find_quest_for(player).should be_a(Quest) 
    end 
  end

  describe "marking a quest as abusive" do
    before do
      @quest = Quest.create
    end      

    it "should create a abusive move for the given player" do
      mock_player.should_receive(:create_abusive_move).with(@quest) 
      @quest.mark_as_abuse!(mock_player)
    end

    it { proc { @quest.mark_as_abuse!(mock_player) }.should change(@quest, :abuses_reported).by(1) }
    
  end 
  
end
