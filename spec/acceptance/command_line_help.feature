Feature: help
  Background:
    Given a command line
    # And working directory 'examples'

  Scenario: running access2rails with no command line options
    When the user runs 'access2rails'
    Then the output should include 'Usage:'

  Scenario: running access2rails with -h flag
    When the user runs 'access2rails -h'
    Then the output should include 'Usage:'

  Scenario: running access2rails with invalid option
    When the user runs 'access2rails help --blah'
    Then the output should include 'invalid option'
    And the output should include 'Usage:'
