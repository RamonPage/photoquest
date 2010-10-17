require 'spec_helper'

describe ChallengesHelper do
  
  describe ".li_for" do
    
    it "should return a li without any class when answer is neither correct, nor chosen" do
      params = { :answer => "London", :correct => "Madrid", :chosen => "Rome" }
      helper.li_for(params).should == "<li>London</li>"
    end
    
    it "should return a li with both classes 'correct' and 'win' when answer is the correct one" do
      test_for  :answer => "Madrid", :correct => "Madrid", :chosen => "Madrid", :classes => "correct win" 
    end
    
    it "should return a li with class 'incorrect' when the chosen answer is incorrect" do
      test_for :answer => "Madrid", :correct => "Lisbon", :chosen => "Madrid" , :classes => "incorrect"
    end
    
    it "should return a li with class 'correct' when the answer is the correct one but the chosen isn't" do
      test_for :answer => "Madrid", :correct => "Madrid", :chosen => "Rio" ,  :classes => "correct"
    end
    
    def test_for(params)
      helper_params = { :answer => params[:answer], :correct => params[:correct], :chosen => params[:chosen] }
      helper.li_for(helper_params).should == %{<li class="#{params[:classes]}">Madrid</li>}
    end 
  end
  
end
