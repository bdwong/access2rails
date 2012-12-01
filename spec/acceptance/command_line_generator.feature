Feature: help
  Background:
    Given a command line

  Scenario: running access2rails with no command line options
    When the user runs 'access2rails'
    Then the output should include 'Usage:'
