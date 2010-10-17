require 'spec_helper'

describe PastMove do


  describe "when retrieving its answers" do
    
    it "should return a list with 5 answers" do 
      @move = AnswerMove.get("move1")
      @past_move = PastMove.new(@move)
      @past_move.answers.size.should be_eql(5)
    end

    context "the move was not right" do
      before do
        @move = AnswerMove.get("move1")
        @past_move = PastMove.new(@move)
      end 
      it "should fetch the correct answer from the given move" do
        @past_move.answers.should include({:answer => "Chicago", :class => "correct" })
      end
      it "should fetch the answer the player gave as :incorrect" do
        @past_move.answers.should include({:answer => "Portland", :class => "incorrect" })
      end
      it "should have none answer marked as 'correct win' " do
        @past_move.answers.select { |answer| answer[:class].eql?("correct win") }.should be_blank
      end
      it "should have 3 answers with class nil" do
        @past_move.answers.select { |answer| answer[:class].nil? }.size.should == 3 
      end 
    end
    context "the move was correct" do
      before do
        @move = AnswerMove.get("correct_move1")
        @past_move = PastMove.new(@move)
      end

      it "should have 4 answers with the class nil" do
        @past_move.answers.select { |answer| answer[:class].nil? }.size.should == 4 
      end
      it "should have an answer as 'correct win'" do
        @past_move.answers.should include({:answer => "Windsor", :class => "correct win" })
      end 
    end 
    
  end 

end 
