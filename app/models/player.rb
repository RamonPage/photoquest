class Player < CouchRest::Model::Base
  collection_of :moves 
end 
