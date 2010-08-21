
Feature: Users lists

  @last_registereds @last_accessed
  Scenario Outline: Default profiles order is based on timestamp creation 
    Given an anonymous session
    And the following users exist:
      | email            | name | <order>             |
      | john@example.com | John | 1990-01-01 10:00:00 |
      | jane@example.com | Jane | 1990-01-02 10:00:00 |
    When I go to the <page> page
    Then the "profiles" box has these boxes in the same order:
      | User name | Jane  |
      | User name | John  |

    Scenarios:
      | order            | page         |
      | validated_at     | users        |
      | current_login_at | recent users |

  Scenario: A user is connected during 30 minutes
    Given an anonymous session
    And the following users exist:
      | email            | name | current_login_at  |
      | john@example.com | John | 35 minutes ago |
      | jane@example.com | Jane | 25 minutes ago |
    When I go to the connected users page
    Then the "profiles" box does not contain "John"
    And the "profiles" box contains "Jane"

  Scenario: Every time the users log in its last acess timestamp is updated
    Given an anonymous session
    And the following users exist:
      | email            | password | name | current_login_at |
      | john@example.com | test     | John | 10 minutes ago   |
      | jane@example.com | test     | Jane | 1 day ago        |
    When I go to the login page
    And I fill in the following:
      | Email     | jane@example.com |
      | Password  | test             |
    And I submit the form
    And I go to the connected users page
    Then the "profiles" box has these boxes in the same order:
      | User name | Jane  |
      | User name | John  |
