class AbusiveMove < Move
  belongs_to :quest 

  def earned_points
    0 
  end
  
end
