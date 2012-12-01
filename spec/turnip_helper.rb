# Require turnip steps
Dir.glob("spec/steps/**/*steps.rb") do |f|
  puts "File: #{f}"
  load f, true
end

RSpec.configure do |config|
  config.include CommandLineSteps
end