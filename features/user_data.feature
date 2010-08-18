
Feature: User data modification

    Scenario Outline: When a user changes email, it has to be valid and unique
        Given a session for the user "john@example.com"
        And a user exists with email: "jane@example.com"
        When I go to the account settings page
        And I type "<email>" on the "email" field
        And I submit the form
        Then these fields have errors: email

        Scenarios:
            | email             |
            | onlyuser          |
            | foo@test          |
            | @cual.com         |
            | john@example.com  |
            | jane@example.com  |

    Scenario: Email changes has to be validated by email
        Given a session for the user "john@example.com"
        When I go to the account settings page
        And I type "john.two@example.com" on the "email" field
        And I submit the form
        Then email was sent with subject: "Email address validation", to: "john.two@example.com"

    Scenario: Email change confirmation
        Given a user exists with email: "first@example.com", name: "Test user"
        And a email change request exists with key: "1234", new email: "second@example.com", user: "first@example.com"
        When I go to the validate email change page with key: "1234"
        Then a user should exist with email: "second@example.com", name: "Test user"

    Scenario: Logged user see personal prefs form
        Given a session for the user "john@example.com"
        When I go to personal data settings page
        And I fill the "prefs" form with:
            | name              | John              |
            | surname           | Example           |
            | born              | 1970-01-01        |
            | gender            | male              |
            | profession        | programmer        |
            | profile           | foo               |
            | hobbies           | bar               |
            | tags              | foo, bar          |
            | city              | new york          |
            | postal_code       | 00001             |
            | country_id        | 1                 |
            | region_id         | 2                 |
            | msn_messenger     | john@msn.com      |
            | yahoo_messenger   | john@yahoo.com    |
            | gtalk             | john@gmail.com    |
            | skype             | john@skype.com    |
            | web               | www.john.com      |
            | show_public_email | true              |
            | twitter_rss       | twitter_john      |
        And I submit the form
        Then a user should exist with email: "john@example.com", name: "John", surname: "Example", born: "01/01/10970", gender: "male", profession: "programmer", profile: "foo", hobbies: "bar", city: "new york", postal_code: "00001", country_id: "1", region_id: "2", msn_messenger: "john@msn.com", yahoo_messenger: "john@yahoo.com", gtalk: "john@gmail.com", skype: "john@skype.com", web: "www.john.com", show_public_email: true, twitter_rss: "twitter_john"
