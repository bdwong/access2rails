Feature: Generate Models
  Background:
    Given a command line
    And a new rails project at 'tmp/project'
    And example files at 'examples/switchboard'
    # And working directory 'tmp/project'

  Scenario: running access2rails to generate models
    When the user runs 'access2rails generate' on examples
    Then there should be 1 file in 'tmp/project/app/models'
    And the file should be named:
    | Name                      |
    | switchboard_item.rb       |

  Scenario: running access2rails to not generate models
    When the user runs 'access2rails generate --no-models' on examples
    Then the output should not include 'invalid option'
    And there should be no files in 'tmp/project/app/models'
