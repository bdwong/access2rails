Feature: help
  Background:
    Given a command line

  Scenario: running access2rails with no command line options
    When the user runs 'access2rails'
    Then the output should include 'Usage:'

  Scenario: running access2rails with -h flag
    When the user runs 'access2rails -h'
    Then the output should include 'Usage:'

  Scenario: running access2rails with invalid option
    When the user runs 'access2rails --blah'
    Then the output should include 'invalid option'
    And the output should include 'Usage:'

  Scenario: running access2rails but file not found
    When the user runs 'access2rails not-a-file.xsd'
    Then the output should not include 'File not found'

  Scenario: running access2rails on empty folder
    When the user runs 'access2rails examples/empty'
    Then the output should include 'No files to process!'
    And the output should include 'Usage:'
