
Feature: Admin users creation an deletion
    
    Scenario Outline: non admin users can not access administration page
        Given <session> session
        When I go to the administrators page
        Then I see <content>

        Scenarios:
            | session           | content           |
            | an anonymous      | "login form" box  |
            | a regular user    | forbidden page    |

    Scenario: Administrators index only shows admin users
        Given an admin session
        And a user exists with email: "admin@example.com", admin: true
        And a user exists with email: "john@example.com", admin: false
        When I go to the administrators page
        Then the "admins" box does not contain "john@example.com"
        And the "admins" box contains "admin@example.com"

    Scenario: Admin can add new admins
        Given an admin session
        And a user exists with email: "john@example.com"
        When I go to the administrators page
        And I click on "New admin"
        And I fill the "new admin" form with:
            | email | john@example.com  |
        And I submit the form
        Then the "admins" box contains "john@example.com"

    Scenario: Admin can delete admins
        Given an admin session
        And a user exists with email: "john@example.com", admin: "true"
        When I go to the administrators page
        And I click on "Remove admin role for john@example.com"
        Then a user should exist with admin: false, email: "john@example.com" 

    Scenario: New admin user has to exist
        Given an admin session
        When I open index administrators page
        And I fill the "new admin" form with:
            | email | foo   |
        And I submit the form
        Then the flash box contains "User with email 'foo' was not found"
