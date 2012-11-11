begin
  require 'active_record'
  require 'simplecov'

  SimpleCov.start do
    add_filter "spec/"
  end
rescue LoadError
  # simplecov is not compatible with ruby 1.8
end

require 'rspec'
require 'roxml'
require File.dirname(__FILE__) + '/../lib/access2rails'

# Require shared examples and other support files
Dir["./spec/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter = 'documentation'
end