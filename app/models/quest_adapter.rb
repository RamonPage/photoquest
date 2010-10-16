class QuestAdapter < CouchRest::Model::Base
  
  property :image_url, String
  property :page_where_image_is, String
  property :correct_answer, String
  property :incorrect_answer1, String
  property :incorrect_answer2, String
  property :incorrect_answer3, String
  property :incorrect_answer4, String
  
end