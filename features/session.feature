
Feature: User session management

  Scenario: An anonymous user can see the loggin form
    Given an anonymous session
    When I go to the login page
    Then I see the "login form" box

  Scenario: A logged user can not see login form
    Given a session for the user "john@example.com"
    When I go to the login page
    Then the current page is the logged user's profile

  Scenario Outline: An anonymous try to login
    Given an anonymous session
    And a user exists with email: "john@example.com", password: "test.pw"
    When I go to the login page
    And I fill in the following:
      | Email     | <email>       |
      | Password  | <password>    |
    And I submit the form
    Then I see the user sessions page
    And the flash box contains "Invalid credentials."

    Scenarios:
      |                   |       |
      |                   | bar   |
      |                   | foo   |
      | foo@bar.com       |       |
      | foo@bar.com       | bar   |
      | foo@bar.com       | foo   |
      | john@example.com  |       |
      | john@example.com  | bar   |


  Scenario: A logged user becomes anonymous after logout
    Given a regular user session
    When I go to the logout page
    Then the session is empty

  Scenario: Users can log in using the login form
    Given a user exists with email: "john@example.com", password: "test.pw"
    When I go to the login page
    And I fill in the following:
      | Email    | john@example.com |
      | Password | test.pw          |
    And I submit the form
    Then the flash box contains "Logged in. Welcome back!"
