# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/access2rails/(.+)\.rb$})     { |m| "spec/#{m[1]}_spec.rb" }
  watch('lib/access2rails/access2rails.rb')     { "spec" }
  watch('spec/spec_helper.rb')  { "spec" }
  watch(%r{^spec/support/(.+)\.rb$}) { "spec" }

  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$})   { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance' }
end
