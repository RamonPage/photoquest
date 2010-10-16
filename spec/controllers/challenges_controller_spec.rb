require 'spec_helper'

describe ChallengesController do
  
  describe "GET index" do
    
    it "should have a quest" do
      get :index
      assigns(:quest).answer.should == "Chicago"
    end
    
  end
  
  describe "POST move" do
    
    it "should return a move with incorrect answer" do
      post :move, :id => "quest1", :answer => "Portland"
      assigns(:move).correct.should be_false
    end

    it "should return a move with correct answer" do
      post :move, :id => "quest1", :answer => "Chicago"
      assigns(:move).correct.should be_true
    end
    
  end

end
