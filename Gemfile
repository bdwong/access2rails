source 'https://rubygems.org'

# Specify your gem's dependencies in access2rails.gemspec
gemspec

gem 'wdm', '~> 0.0.3', :platforms => [:mswin, :mingw]
os = `uname`
if os =~ /Linux/
  gem 'rb-inotify'
end