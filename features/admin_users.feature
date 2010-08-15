
Feature: Admin users creation an deletion
    
    Scenario Outline: non admin users can not access administration page
        Given <session> session
        When I open index administrators page
        Then I see <content>

        Scenarios:
            | session           | content           |
            | an anonymous      | "login form" box  |
            | a regular user    | forbidden page    |

    Scenario: Index page lists only admin users
        Given an admin session
        And a user exists with email: "admin@xiraxi.com", is_admin: true
        And a user exists with email: "john@example.com", is_admin: false
        When I open index administrators page
        Then I see one "admin" item
        And the page contains these boxes within "admin":
            | email | admin@xiraxi.com  |

    Scenario: Admin can add new admins
        Given an admin session
        And a regular user with email "john@example.com"
        When I open index administrators page
        And I go to "new admin" page
        And I fill the "new admin" form with:
            | email | john@example.com  |
        And I submit the form
        Then I see index administrators page
        And user with email "john@example.com" is admin

    Scenario: Admin can delete admins
        Given an admin session
        And a user with email "john@example.com", is_admin: "true"
        When I open index administrators page
        And submit "delete" form for "admin" item with:
            | email | john@example.com  |
        Then user with email: "john@example.com" is a regular user

    Scenario: New admin user has to exist
        Given an admin session
        When I open index administrators page
        And I fill the "new admin" form with:
            | email | foo   |
        And I submit the form
        Then I see index administrators page
        And the flash box contains "User with email 'foo' was not found"
