# encoding: utf-8

require 'spec_helper'

describe Quest do
  
  describe "properties" do
    
    before(:each) do
      Fixtures.load
    end
    
    it "should have the expected properties" do
      quest = Quest.first
      quest.image_url.should ==  "http://farm4.static.flickr.com/3081/2558637383_96104ccea4.jpg"
      quest.questions.should == %w(Portland Chicago Rio Paris London)
      quest.answer.should == "Chicago"
    end
    
  end
  
end
