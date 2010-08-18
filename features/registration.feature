
Feature: Registration in the web

    Scenario: A logged user can not see registration form
        Given a regular user session
        When I go to the signup page
        Then the current page is the logged user's profile

    Scenario: An anonymous user see the reCaptcha in the second step
        Given an anonymous user
        When I go to the signup page
        And I fill in the following:
            | email                 | dude@example.com |
            | password              | foobar           |
            | password confirmation | foobar           |
            | name                  | Dude             |
            | surname               | Example          |
            | acceptance            | checked          |
        And I submit the form
        Then the page contains a "recaptcha" box 

    Scenario: Anonymous user has to check acceptance
        Given an anonymous user
        When I go to the signup page
        And I fill in the following:
            | email                     | dude@example.com |
            | password                  | foobar           |
            | password confirmation     | foobar           |
            | name                      | Dude             |
            | surname                   | Example          |
        And I submit the form
        Then the form field "acceptance" has an error

    Scenario: Password has to be confirmed
        Given an anonymous user
        When I go to the signup page
        And I fill in the following:
            | email                     | dude@example.com |
            | password                  | foobar           |
            | password confirmation     | foOBAr           |
            | name                      | Dude             |
            | surname                   | Example          |
        And submit the form
        Then the form field "password confirmation" has an error

    Scenario Outline: Email address has to be valid and unique
        Given an anonymous session
        And a user exists with email: "john@example.com"
        When I go to the signup page
        And I fill in the following:
            | email                     | <email>          |
            | password                  | foobar           |
            | password confirmation     | foobar           |
            | name                      | Dude             |
            | surname                   | Example          |
        And I submit the form
        Then the form field "email" has an error

        Scenarios:
            | email             |
            | onlyuser          |
            | foo@test          |
            | @cual.com         |
            | john@example.com  |
            | john@eXAmple.com  |
            | John@eXAmple.com  |

    Scenario: When anonymous user registers, a confirmation email is sent
        Given an anonymous user
        When I go to the signup page
        And I fill in the following:
            | email                 | dude@example.com |
            | password              | foobar           |
            | password confirmation | foobar           |
            | name                  | Dude             |
            | surname               | Example          |
            | acceptance            | checked          |
        And I submit the form
        And I force the reCaptcha to be valid
        Then the flash box contains "An email was sent to confirm your address."
        And an email was sent with subject: "Account validation"
