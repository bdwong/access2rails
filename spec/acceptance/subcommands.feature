Feature: Subcommands
  Background: In order to let the user perform different operations using the same main executable so that the user doesn't have to remember different executable names
    Given a command line
    # And working directory 'examples'
  Scenario: running access2rails help
    When the user runs 'access2rails help'
    Then the output should include "Run 'access2rails help commands'"

  Scenario: running access2rails help commands
    When the user runs 'access2rails help commands'
    Then then the user should see the list of subcommands

  Scenario: running access2rails load with no options
    When the user runs 'access2rails load'
    Then the output should include 'access2rails load'

  Scenario: running access2rails generate with no options
    When the user runs 'access2rails generate'
    Then the output should include 'access2rails generate'

  Scenario: running access2rails with invalid subcommand
    When the user runs 'access2rails not-a-subcommand'
    Then the output should include "'not-a-subcommand' is not a valid subcommand"
    And the output should include 'Usage:'
