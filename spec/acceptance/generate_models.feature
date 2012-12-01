Feature: Generate Models
  Background:
    Given a command line
    And a new rails project at 'tmp/project'
    And example files at 'examples/switchboard'
    # And working directory 'tmp/project'

  Scenario: running access2rails to generate models
    When the user runs 'access2rails' on examples
    Then the output should include 'Generating model'
    And there should be 1 file in 'tmp/project/app/models'

  Scenario: running access2rails to not generate models
    When the user runs 'access2rails --no-models' on examples
    Then the output should not include 'invalid option'
    And the output should not include 'Generating model'
    And there should be no files in 'tmp/project/app/models'
