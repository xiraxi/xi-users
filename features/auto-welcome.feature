
Feature: Auto-welcome

    Scenario: When a user validates his account, auto-welcome is posted on his profile.
        Given a user exists with email: "john@example.com", password: "john"
        And a auto-welcome with text: "Welcome", user: "admin@xiraxi.com"
        When the user "john@example.com" validates account
        Then a comment with text: "Welcome", user: "admin@xiraxi.com", father: "john@example.com" is created

    Scenario Outline: CRUD for auto-welcome only for admin
        Given a not admin session
        When I open <action>
        Then I see the forbidden page

        Scenarios:
            | action    |
            | index     |
            | change    |

    Scenario: admin user can edit auto-welcome
        Given an admin session
        And a user with email: "john@example.com"
        When I open change auto-welcome page
        And I fill the "auto-welcome" form with:
            | user  | "john@example.com"    |
            | text  | Welcome               |
        And I submit the form
        Then I see the index auto-welcome page
        And the flash box contains "Auto-welcome changes saved"
        And auto-welcome is text: "Welcome", user: "john@example.com"

    Scenario Outline: User and text has to be present for auto-welcome
        Given an admin session
        And a user with email: "john@example.com"
        When I open change auto-welcome page
        And I fill the "auto-welcome" form with:
            | user  | <user>    |
            | text  | <text>    |
        And I submit the form
        Then I see change auto-welcome page
        And the flash box contains <error_message>
        
            Scenarios:
                | user              | text      | error_message             |
                | foo               | Welcome   | User not found            |
                | john@example.com  |           | Content can not be blank  |
