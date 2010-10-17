class Move < CouchRest::Model::Base
  
  property :earned_points, :default => 0
  belongs_to :player
  
end
