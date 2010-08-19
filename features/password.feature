
Feature: Password management

    Scenario Outline: Anonymous user can request a reset password
        Given an anonymous user
        And a user exists with email: "john@example.com"
        When I go to the reset password page
        And I fill in the following:
            | email | john@example.com |
        And I submit the form
        Then the flash box contains "An email was sent to john@example.com with instructions to reset your password"
        And an email was sent with subject: "Reset password confirmation"

    Scenario: Password change confirmation
        Given a user exists with email: "john@example.com"
        And a password change request exists with key: "1234", new password: "test.one", user: "john@example.com"
        When I go to the password change page with key: "1234"
        Then a user should exist with email: "john@example.com", password: "foo"

    Scenario Outline: When change the password the user has to confirm the change with the current password
        Given a user exists with email: "john@example.com", password: "test.one"
        And a session for the user "john@example.com"
        When I go to the change password page
        And I fill in the following:
            | current password      | <current> |
            | password              | <first>   |
            | password confirmation | <second>  |
        And I submit the form
        Then the flash box contains "Invalid"

        Scenarios:
            | current | first | second |
            | foo     | bar   | BAR    |
            | foo     | qiz   | bar    |
            | qiz     | bar   | bar    |
