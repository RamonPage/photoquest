# encoding: utf-8

require 'spec_helper'

describe AnswerMove do
  
  describe "properties" do
    
    it "should have the expected properties" do
      move = AnswerMove.find("move1")
      move.quest_id.should == "quest1"
      move.answer.should == "Portland" 
    end
    
  end

  describe "when looking for the correct answer" do
    it "should return the correct answer from its quest" do
      move = AnswerMove.find("move1") 
      move.correct_answer.should == "Chicago" 
    end 
  end 
  
end
