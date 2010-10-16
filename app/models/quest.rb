class Quest < CouchRest::Model::Base
  
  property :image_url, String
  property :page_where_image_is, String
  property :questions, [String]
  property :answer, String
  
  def correct_answer?(answer)
    self.answer == answer
  end
  
  def self.draw
    Quest.all.draw.first
  end
  
end