
Feature: Password management

  Scenario: Anonymous user can request a reset password
    Given an anonymous session
    And a user exists with email: "john@example.com"
    When I go to the request reset password page
    And I fill in "john@example.com" for "Email"
    And I submit the form
    Then the flash box contains "An email was sent to john@example.com with instructions to reset your password"
    And an email was sent with subject: "Reset password confirmation"

  Scenario: Password change confirmation
    Given an anonymous session
    And a user: "john" exists with email: "john@example.com"
    And a reset password request exists with key: "1234", user: user "john"
    When I go to the reset password page with id: "1234"
    And I fill in "new.password" for "Password"
    And I fill in "new.password" for "Password confirmation"
    And I submit the form
    Then the password for "john@example.com" is "new.password"
    And the flash box contains "Your password has been updated."

  Scenario Outline: When change the password the user has to confirm the change with the current password
    Given a user exists with email: "john@example.com", password: "test.one"
    And a session for the user "john@example.com"
    When I go to the change password page
    And I fill in the following:
      | Current password      | <current> |
      | Password              | <first>   |
      | Password confirmation | <second>  |
    And I submit the form
    Then these fields have errors: <invalid>

    Scenarios:
      | current | first        | second       | invalid               |
      | test.pw | different    | notiqual     | Password              |
      | other   | new.password | new.password | Current password      |
      | test.pw | x            | x            | Password confirmation |
