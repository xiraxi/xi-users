
Feature: activation pending users

    Scenario Outline: Non-admin users can not access activation pending users
        Given <session> session
        When I open activation pending users page
        Then I the <content>

        Scenarios:
            | session               | content           |
            | an anonymous session  | "login form" box  |
            | a regular  user       | forbidden page    |

    Scenario Outline: Non-admin users can not validate activation pending users
        Given <session> session
        When I open validate activation pending users page
        Then I the <content>

        Scenarios:
            | session               | content           |
            | an anonymous session  | "login form" box  |
            | a regular  user       | forbidden page    |

    Scenario: An admin can view activation pending users
        Given an admin session
        And a user with email: "john@example.com", validated_at: nil, validate_key: 1234
        And a user with email: "jane@xample.com", validates_at: 1970-01-01, validate_key: nil
        When I open activation pending users page
        Then I see one "user" item
        And the "user" box contains "john@example.com"

    Scenario: An admin can activate pending users
        Given an admin session
        And a user with email: "john@example.com", validated_at: nil, validate_key: 1234
        When I open validate activation pending users page with email: "john@example.com"
        Then user with email: "john@example.com" is validated
        And I see the activation pending users page
        And I see no "user" item

    Scenario Outline: Admin can not activate emails not in database
        Given an admin session for the user with email: "admin@xiraxi.com"
        When I open validate activation pending users page with email: <email>
        Then I see the error page

        Scenarios:
            | email             |
            | foo               |
            | foo@              |
            | john@example.com  |
            |                   |
