# Require turnip steps
Dir.glob("spec/acceptance/steps/**/*steps.rb") do |f|
  load f, true
end

RSpec.configure do |config|
  config.include CommandLineSteps
end