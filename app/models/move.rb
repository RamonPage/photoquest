class Move < CouchRest::Model::Base
  
  property :quest_id, String
  property :correct, TrueClass
  
end