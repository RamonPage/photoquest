class QuestAdapter < CouchRest::Model::Base
  
  property :image_url, String
  property :page_where_image_is, String
  property :wrong_answer1, String
  property :wrong_answer2, String
  property :wrong_answer3, String
  property :wrong_answer4, String
  property :correct_answer, String
  
end