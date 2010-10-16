require 'spec_helper'

describe ChallengesController do
  
  before(:each) do
    quest = Quest.first
    Quest.stub!(:draw).and_return(quest)
  end
  
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

    context "with a correct answer" do 
      before :each do
        post :move, :id => "quest1", :answer => "Chicago"
      end 
      it "should return a move" do
        assigns(:move).correct.should be_true
      end
    
      it "should redirect to the index page" do
        response.should render_template(:index)
      end   
    end 
  end

end
