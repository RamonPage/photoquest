if Rails.env.to_s != "production"
  require 'rspec/core'
  require 'rspec/core/rake_task'

  namespace :spec do
    desc "Run the code examples in spec/acceptance"
    RSpec::Core::RakeTask.new(:acceptances => :noop) do |t|
      t.pattern = "./spec/acceptance/**/*_spec.rb"
    end
  end
end