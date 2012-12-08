Feature: the generate subcommand
  Background: In order to perform schema and model generation in a subcommand
    Given a command line in 'examples'

  Scenario: running access2rails but file not found
    When the user runs 'access2rails generate does-not-exist.xsd'
    Then the output should include 'File not found'

