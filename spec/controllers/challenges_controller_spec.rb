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

    context "when the user has a session already recorded" do
      it "should fetch its id" do
        session[:player_id] = "player1" 
        get :index
        assigns[:player].id.should == "player1" 
      end 
    end
    
    context "when the user doesn't have a session yet" do
      it "should create a new player and record it's id in a corresponding session" do
        session[:player_id] = nil
        player = Player.new :id => "123"
        Player.should_receive(:create).and_return(player)
        get :index
        assigns(:player).should == player
        session[:player_id].should == "123"
      end
    end
     
  end
  
  describe "POST move" do
    it "should return a move with incorrect answer" do
      post :move, :id => "quest1", :answer => "Portland"
      assigns(:move).correct?.should be_false
    end

    context "with a correct answer" do 
      before :each do
        post :move, :id => "quest1", :answer => "Chicago"
      end 
      it "should return a move" do
        assigns(:move).correct?.should be_true
      end
    
      it "should redirect to the index page" do
        response.should render_template(:index)
      end   
    end 
  end

end
