require "access2rails/version"
require 'active_support'
require 'active_support/core_ext/string'

require "access2rails/model_generator"
require "access2rails/migration_generator"
require "access2rails/xsd/xsd"

module Access2rails
  LIBDIR=File.expand_path(File.dirname(__FILE__), "..")
  PROJECT_DIR=File.expand_path(File.join(File.dirname(__FILE__), ".."))
end
