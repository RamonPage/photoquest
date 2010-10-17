ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'fixtures'
require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

def fetch_quest_from_move(move_id)
  Move.find(move_id).quest
end

def mock_player(stubs={})
  @mock_player ||= mock_model(Player,stubs).as_null_object 
end
def mock_move(stubs={})
  @mock_move ||= mock_model(Move,stubs).as_null_object 
end



RSpec.configure do |config|
  config.mock_with :rspec
  
  config.before(:each) do
    Fixtures.create_db
    Fixtures.load
  end

  config.after(:each) do
    Fixtures.delete_db
  end
end

