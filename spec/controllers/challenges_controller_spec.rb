require 'spec_helper'

describe ChallengesController do
  
  describe "GET index" do
    
    it "should have a quest" do
      get :index
      assigns(:quest).answer.should == "Chicago"
    end
    
  end

end
