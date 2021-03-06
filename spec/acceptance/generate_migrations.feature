Feature: Generate Migrations
  Background:
    Given a command line
    And a new rails project at 'tmp/project'
    And example files at 'examples/switchboard'
    # And working directory 'tmp/project'

  Scenario: running access2rails generate on empty folder
    When the user runs 'access2rails generate examples/empty'
    Then the output should include 'No files to process!'
    And the output should include 'Usage:'

  Scenario: running access2rails to generate migrations
    When the user runs 'access2rails generate' on examples
    Then there should be 1 file in 'tmp/project/db/migrate'
    And the file should be named:
    | Name                                       |
    | ??????????????_create_switchboard_items.rb |

  Scenario: running access2rails to not generate migrations
    When the user runs 'access2rails generate --no-migrations' on examples
    Then the output should not include 'invalid option'
    And there should be no files in 'tmp/project/db/migrate'
