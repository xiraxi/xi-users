
Feature: Validation pending users CRUD feature

  Scenario Outline: non admin users can not access validation pending users page
    Given <session> session
    When I go to the validation pending users page
    Then I see the <content>

    Scenarios:
      | session           | content           |
      | an anonymous      | "login form" box  |
      | a regular user    | forbidden page    |

  Scenario: list only show validation pending users
    Given an admin session
    And the following users exist:
      | email            | name | confirmed_at        |
      | john@example.com | John | 1990-01-01 10:00:00 |
      | jane@example.com | Jane |                     |
    When I go to the validation pending users page
    Then the "items" box does not contain "John"
    And the "items" box contains "Jane"

  Scenario: admin can validate user
    Given an admin session
    And the following users exist:
      | email            | name | confirmed_at        |
      | john@example.com | John |                     |
    When I go to the validation pending users page
    And I click on "Validate"
    Then the "items" box does not contain "John"
