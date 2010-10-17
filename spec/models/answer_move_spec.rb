# encoding: utf-8

require 'spec_helper'

describe AnswerMove do
  
  describe "properties" do
    
    it "should have the expected properties" do
      move = AnswerMove.first
      move.quest_id.should == "quest1"
      move.answer.should == "Portland"
    end
    
  end

  describe "when looking for the correct answer" do
    context "when a quest is provided" do
      it "should ask the quest whether this answer is correct or not" do
        mock_quest.should_receive(:correct_answer?).and_return([])
        move = AnswerMove.new
        move.correct_answer?(mock_quest).should be_eql([]) 
      end
    end 
  end 
  
end
