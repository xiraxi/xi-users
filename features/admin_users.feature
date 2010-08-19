
Feature: Admin users creation an deletion

  Scenario Outline: non admin users can not access administration page
    Given <session> session
    When I go to the administrators page
    Then I see the <content>

    Scenarios:
      | session           | content           |
      | an anonymous      | "login form" box  |
      | a regular user    | forbidden page    |

  Scenario: Administrators index only shows admin users
    Given an admin session
    And a user exists with email: "admin@example.com", admin: true
    And a user exists with email: "john@example.com", admin: false
    When I go to the administrators page
    Then the "admins" box does not contain "john@example.com"
    And the "admins" box contains "admin@example.com"

  Scenario: Admin can add new admins
    Given an admin session
    And a user exists with email: "john@example.com"
    When I go to the administrators page
    And I fill in "john@example.com" for "Email" within "new admin"
    And I submit the form
    Then the "admins" box contains "john@example.com"

  Scenario: Admin can delete admins
    Given an admin session
    And a user exists with email: "john@example.com", admin: "true"
    When I go to the administrators page
    And I click on "Revoke admin grant for john@example.com"
    Then the flash box contains "Revoked admin grant."
    And a user should exist with role: "", email: "john@example.com" 

  Scenario: New admin user has to exist
    Given an admin session
    When I go to the administrators page
    And I fill in "john@example.com" for "Email" within "new admin"
    And I submit the form
    Then the flash box contains "Unknown admin."
