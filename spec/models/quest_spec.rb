# encoding: utf-8

require 'spec_helper'

describe Quest do
  
  describe "properties" do
    
    it "should have the expected properties" do
      quest = Quest.first
      quest.image_url.should ==  "http://farm4.static.flickr.com/3081/2558637383_d8a797b758_o.jpg"
      quest.page_where_image_is = "http://www.flickr.com/photos/viniciusteles/2558637383/in/set-72157605484089896/"
      quest.questions.should == %w(Portland Chicago Rio Paris London)
      quest.answer.should == "Chicago"
      quest.correct_answer?("Portland").should be_false
      quest.correct_answer?("Chicago").should be_true
    end
    
  end
  
end
