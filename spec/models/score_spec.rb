# encoding: utf-8

require 'spec_helper'

describe Score do

  describe ".calculate" do
    
    before(:each) do
      @quest1 = Quest.get "quest1"
      @quest2 = Quest.get "quest2"
    end
    
    it "should be 1000 for one correct move" do
      Move.create :quest => @quest1, :answer => "Chicago"
      Score.calculate.should == 1000
    end
    
    it "should be 2000 for two correct move on the same quest" do
      Move.create :quest => @quest1, :answer => "Chicago"
      Move.create :quest => @quest1, :answer => "Chicago"
      Score.calculate.should == 2000
    end
    
    it "should be 2000 for two correct move on different quests" do
      Move.create :quest => @quest1, :answer => "Chicago"
      Move.create :quest => @quest2, :answer => "London"
      Score.calculate.should == 2000
    end
    
    it "shouldn't count the wrong answers" do
      Move.create :quest => @quest1, :answer => "Chicago"
      Move.create :quest => @quest2, :answer => "San Francisco"
      Score.calculate.should == 1000
    end
    
  end
  
end
