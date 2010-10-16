class Quest < CouchRest::Model::Base
  
  property :image_url, String
  property :questions, [String]
  property :answer, String
  
end