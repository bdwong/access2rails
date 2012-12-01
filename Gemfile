source 'https://rubygems.org'

# Specify your gem's dependencies in access2rails.gemspec
gemspec

gem 'wdm', '~> 0.0.3', :platforms => [:mswin, :mingw]

group :development do
  gem 'rb-inotify', :require => false
  gem 'rb-fsevent', :require => false
  gem 'rb-fchange', :require => false
  if `which growlnotify`.empty?
    gem 'ruby_gntp'
  else
    gem 'growl'
  end
end