ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'fixtures'
require 'rspec/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  
  config.before(:each) do
    Fixtures.create_db
  end

  config.after(:each) do
    Fixtures.delete_db
  end
  
end
