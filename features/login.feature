
Feature: Login in the web

    Scenario: An anonymous user can see the loggin form
        Given an anonymous user
        When I open user_login page
        Then the page contains a form named "login"

    Scenario: A logged user can not see login form
        Given a session for the user "john@example.com"
        When I open user_login page
        Then the profile of the logged user is loaded

    Scenario Outline: An anonymous try to login
        Given an anonymous user
        And a user with "email" set to "john@example.com" and "password" set to "foo"
        When I open de user_login page
        And fill the form with:
            | email     | <email>       |
            | password  | <password>    |
        And submit the form
        Then the user_login page is loaded
        And the page contains a box with id "error"

        Scenarios:
            |                   |       |
            |                   | bar   |
            |                   | foo   |
            | foo@bar.com       |       |
            | foo@bar.com       | bar   |
            | foo@bar.com       | foo   |
            | john@example.com  |       |
            | john@example.com  | bar   |
