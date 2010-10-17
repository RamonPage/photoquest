require 'spec_helper'

describe ChallengesController do
  
  before(:each) do
    quest = Quest.first
    Quest.stub!(:draw).and_return(quest)
  end

  describe "POST /create" do
    before do
      session[:player_id] =  "player1"
      Player.stub!(:get).with('player1').and_return(mock_player)
      @params = { "twitter"  => "pellegrino" , "foo" => "bar" }
    end 
    it "should retrieve the current player" do
      post :create, :quest => @params 
      assigns[:player].should be_eql(mock_player) 
    end

    it "should record the current player's quest contribution" do
      mock_player.should_receive(:create_quest).with(@params).and_return(mock_quest) 
      post :create, :quest => @params
      assigns[:quest].should be_eql(mock_quest) 
    end
  end 

  describe "GET index" do
    
    it "should have a quest" do
      get :index
      assigns(:quest).correct_answer.should == "Chicago"
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
    before do
      session[:player_id] = "1234"
      Player.stub!(:get).with("1234").and_return(mock_player) 
    end
    
    it "should create a move for this player" do 
      mock_player.should_receive(:create_answer_move).with(:quest_id => 'quest1', :answer => 'Portland').and_return(mock_move)
      post :move, :id => "quest1" , :answer => "Portland"
      assigns[:move].should be_eql(mock_move)
    end 
    

    context "with a correct answer" do 
      before :each do
        post :move, :id => "quest1", :answer => "Chicago"
      end 
      it "should return a move" do
        assigns(:move).correct_answer?.should be_true
      end
    
      it "should redirect to the index page" do
        response.should redirect_to challenges_url 
      end   
    end 
  end

end
