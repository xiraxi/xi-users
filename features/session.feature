
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
        And a user exists with email: "john@example.com", password: "foo"
        When I go to the login page
        And I fill the form with:
            | email     | <email>       |
            | password  | <password>    |
        And I submit the form
        Then I see the login page
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
        When I click on "log out"
        Then the session is empty
