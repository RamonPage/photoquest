describe AbusiveMove do


  it "should value 0 points " do
    am  = AbusiveMove.new
    am.earned_points.should == 0 
  end 

end 
