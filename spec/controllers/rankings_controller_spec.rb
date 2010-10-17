require 'spec_helper'

describe RankingsController do

  describe "GET 'index'" do
    it "should return the player rankings" do 
      Player.should_receive(:ranking).and_return([mock_player]) 
      get 'index'
    end
  end

  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should be_success
    end
  end

end
