# -*- encoding: utf-8 -*-
require File.expand_path('../lib/access2rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Brian Wong"]
  gem.email         = ["bdwong.net@gmail.com"]
  gem.description   = %q{Convert MS Access xsl files to rails models and migrations, and import xml data.}
  gem.summary       = %q{Convert MS Access xsl files to rails models and migrations, and import xml data.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "access2rails"
  gem.require_paths = ["lib"]
  gem.version       = Access2rails::VERSION

  gem.add_development_dependency "rspec", ">=2.8"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency "guard"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency 'wdm', '~> 0.0.3'
  gem.add_runtime_dependency "roxml"
  #gem.add_development_dependency "rails", ">=3.0"
end
