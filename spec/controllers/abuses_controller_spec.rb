require 'spec_helper'

describe AbusesController do

  describe "POST 'create'" do
    before do
      Quest.stub!(:get).with('1').and_return(mock_quest)
      subject.stub!(:fetch_current_player).and_return(mock_player)
    end 
    it "should retrieve the quest marked as an abuse" do
      Quest.should_receive(:get).with('1').and_return(mock_quest)
      post :create , :id => '1'
    end

    it "should mark the retrieved quest as an abuse" do
      mock_quest.should_receive(:mark_as_abuse!).with(mock_player) 
      post :create , :id => '1' 
    end

    it "should prepare a message indicating that the quest was reported as abusive" do
      post :create, :id => '1'
      flash[:notice].should_not be_nil
    end 

    it "should redirect_to the challenges_path" do
      post :create , :id => '1'
      response.should redirect_to challenges_url 
    end 
  end

end
