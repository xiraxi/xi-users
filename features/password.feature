
Feature: Password administration

    Scenario: An anonymous user can see password reset form
        Given an anonymous user
        When I open reset_password page
        Then the page contains a form named "reset_password"

    Scenario: A logged user can not see password reset form
        Given a session for the user "john@example.com"
        When I open reset_password page
        Then the comunity_prefs of the logged user is loaded

    Scenario Outline: Email has to be valid to recover password
        Given an anonymous user
        And a user with email john@example.com
        When I open reset_password page
        And fill the form with:
            | email | <email> |
        And submit the form
        Then the form field "email" has an error

        Scenarios:
            | foo           |
            | bar@          |
            | foo@test      | 
            | john@doe.com  |

    Scenario: Password reset is complemented
        Given an anonymous user
        And a user with email john@example.com
        When I open reset_password page
        And fill the form with:
            | email | john@example.com  |
        And submit the form
        Then a reset_password_key for the user john@example.com is created
        And an email with subject "Cambio de contraseña" is sent

    Scenario: Password change confirmation
        Given a user exists with email: "foo@tal.com"
        And a password_change request exist with key: "1234", new password: "foo"
        When I go to password_change page with key: "1234"
        Then user with email "foo@tal.com" has password "foo"

    Scenario Outline: Current password has to be valid
        Given A session fot the user "john@example.com"
        And a user with "email" set to "john@example.com" and "password" set to "foo"
        When I open comunity_prefs page
        And fill the form with:
            | current_password     | <password>   |
        And submit the form
        Then the form field "current_password" has an error

        Scenarios:
            | FOO   |
            | bar   |
            |       |

    Scenario: Password and password confirmation has to be the same
        Given a session got the user "john@example.com"
        When I open comunity_prefs page
        And fill the form with:
            | password                  | foobar           |
            | password confirmation     | foOBAr           |
        And submit the form
        Then the form field "password confirmation" has an error
