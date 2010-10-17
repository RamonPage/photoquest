class Move < CouchRest::Model::Base
  
  belongs_to :player
  
  def earned_points
    0
  end
end
