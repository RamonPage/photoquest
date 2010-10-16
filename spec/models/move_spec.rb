# encoding: utf-8

require 'spec_helper'

describe Move do
  
  describe "properties" do
    
    it "should have the expected properties" do
      move = Move.first
      move.quest_id.should == "quest1"
      move.answer.should == "Portland"
    end
    
  end
  
end
