
Feature: Registration in the web

    Scenario: A logged user can not see registration form
        Given a regular user session
        When I go to the new user page
        Then the current page is the logged user's profile

    Scenario: An anonymous user see the reCaptcha in the second step
        Given an anonymous session
        When I go to the new user page
        And I fill in the following:
            | Email                 | dude@example.com |
            | Password              | foobar           |
            | Password confirmation | foobar           |
            | Name                  | Dude             |
            | Surname               | Example          |
        And I check "I have read the terms and I accept them"
        And I submit the form
        Then the page contains the "recaptcha form" box

    Scenario: Anonymous user has to check acceptance
        Given an anonymous session
        When I go to the new user page
        And I fill in the following:
            | Email                     | dude@example.com |
            | Password                  | foobar           |
            | Password confirmation     | foobar           |
            | Name                      | Dude             |
            | Surname                   | Example          |
        And I submit the form
        Then these fields have errors: user_terms_of_use 

    Scenario: Password has to be confirmed
        Given an anonymous session
        When I go to the new user page
        And I fill in the following:
            | Email                     | dude@example.com |
            | Password                  | foobar           |
            | Password confirmation     | foOBAr           |
            | Name                      | Dude             |
            | Surname                   | Example          |
        And I submit the form
        Then these fields have errors: Password 

    Scenario Outline: Email address has to be valid and unique
        Given an anonymous session
        And a user exists with email: "john@example.com"
        When I go to the new user page
        And I fill in the following:
            | Email                     | <email>          |
            | Password                  | foobar           |
            | Password confirmation     | foobar           |
            | Name                      | Dude             |
            | Surname                   | Example          |
        And I submit the form
        Then these fields have errors: Email 

        Scenarios:
            | email             |
            | onlyuser          |
            | foo@test          |
            | @cual.com         |
            | john@example.com  |
            | john@eXAmple.com  |
            | John@eXAmple.com  |

    Scenario: When anonymous user registers, a confirmation email is sent
        Given an anonymous session
        When I go to the new user page
        And I fill in the following:
            | Email                 | dude@example.com |
            | Password              | foobar           |
            | Password confirmation | foobar           |
            | Name                  | Dude             |
            | Surname               | Example          |
        And I check "I have read the terms and I accept them"
        And I submit the form
        Then I force the reCaptcha to be valid
        Then the flash box contains "An email was sent to confirm your address."
        And an email was sent with subject: "Account validation"

    Scenario: When anonymous user confirms the signup, the user is actived
      Given an anonymous session
      And an invalidated user: "john" exists with email: "john@example.com", perishable_token: "12345"
      When I go to the validate account page with id: "12345"
      Then the user with email "john@example.com" is validated
      And the flash box contains "Your account is validated."

