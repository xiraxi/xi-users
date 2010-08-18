
Feature: activation pending users

    Scenario Outline: Non-admin users can not access activation pending users
        Given <session> session
        When I go to the pending users page
        Then I see the <content>

        Scenarios:
            | session               | content           |
            | an anonymous session  | "login form" box  |
            | a regular  user       | forbidden page    |

    Scenario Outline: Non-admin users can not validate activation pending users
        Given <session> session
        When I go to the pending users page
        Then I the <content>

        Scenarios:
            | session               | content           |
            | an anonymous session  | "login form" box  |
            | a regular  user       | forbidden page    |

    Scenario: An admin can view activation pending users
        Given an admin session
        And a user exists with email: "john@example.com", validated_at: nil, validate_key: 1234
        And a user exists with email: "jane@xample.com", validates_at: 1990-01-01, validate_key: nil
        When I go to the pending users page
        Then the "pending users" box does not contain "jane@example.com"
        And the "pending users" box contains "john@example.com"

    Scenario: An admin can activate pending users
        Given an admin session
        And a user exists with email: "john@example.com", validated_at: nil, validate_key: 1234
        When I go to the pending users page
        And I click on "Active"
        Then a user should exist with activated: true, email: "john@example.com" 
