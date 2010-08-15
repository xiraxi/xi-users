
Feature: Registration in the web

    Scenario: An anonymous user can see the registration form
        Given an anonymous user
        When I open signup page
        Then the page contains a form named "register"

    Scenario: A logged user can not see registration form
        Given a session for the user "john@example.com"
        When I open signup page
        Then the profile of the logged user is loaded

    Scenario: An anonymous user see the reCaptcha in the second steps
        Given an anonymous user
        When I open signup page
        And fill the form with:
            | email                     | dude@example.com |
            | password                  | foobar           |
            | password confirmation     | foobar           |
            | name                      | Dude             |
            | surname                   | Example          |
            | acceptance                | checked          |
        And submit the form
        Then the page contains a box with id "recaptcha"

    Scenario: Anonymous user has to check acceptance
        Given an anonymous user
        When I open signup page
        And fill the form with:
            | email                     | dude@example.com |
            | password                  | foobar           |
            | password confirmation     | foobar           |
            | name                      | Dude             |
            | surname                   | Example          |
        And submit the form
        Then the form field "acceptance" has an error

    Scenario: Password and password confirmation has to be the same
        Given an anonymous user
        When I open signup page
        And fill the form with:
            | email                     | dude@example.com |
            | password                  | foobar           |
            | password confirmation     | foOBAr           |
            | name                      | Dude             |
            | surname                   | Example          |
        And submit the form
        Then the form field "password confirmation" has an error

    Scenario Outline: Email address has to be valid and unique
        Given an anonymous session
        And a user with "email" set to "john@example.com"
        When I open signup page
        And fill the form with:
            | email                     | <email>          |
            | password                  | foobar           |
            | password confirmation     | foobar           |
            | name                      | Dude             |
            | surname                   | Example          |
        And submit the form
        Then the form field "email" has an error

        Scenarios:
            | email             |
            | onlyuser          |
            | foo@test          |
            | @cual.com         |
            | john@example.com  |


    Scenario: When anonymous user registers, a confirmation email is sent
        Given an anonymous user
        When I complete registration
        Then an email with subject "Confirmacion de registro" is sent

    Scenario: When anonymous user confirm the registration, validate_key has to be present
        Given an anonymous user
        When I open validate_register page
        And validate_key is nil
        Then a 404 error is loaded

    Scenario: When anonymous user confirms the registration, validate_key has to be in database
        Given an anonymous user
        When I open validate_register page
        And validate_key is "abcd"
        Then a 404 error is loaded
