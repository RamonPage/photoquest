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
      quest.answers.should == %w(Chicago Portland Rio Paris London)
      quest.correct_answer.should == "Chicago"
      quest.incorrect_answers.should == %w(Portland  Rio Paris London)
      quest.correct_answer?("Portland").should be_false
      quest.correct_answer?("Chicago").should be_true
    end
    
  end

  describe "finding a quest that a given player has not yet answered" do
    it 'should fetch his list of already answered questions' do
      player = mock_model(Player).as_null_object
      player.should_receive(:answered_quests)
      Quest.find_quest_for(player) 
    end

    it "should retrieve a quest that the player hasn't answered yet" do
      player = Player.find("player1")
      player.answered_quests.should_not include(Quest.find_quest_for(player))
    end 
  end 
  
end
