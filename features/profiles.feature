
Feature: User profiles

    Scenario: An anonymous user can only view others profile
        Given an anonymous user
        And a user with email: "john@example.com"
        When I open "john@example.com" profile page
        Then the page not contains a box with class "user_actions"

    Scenario: Logged user can not do actions to herself
        Given a session for the user "john@example.com"
        When I open "john@example.com" profile page
        Then the page not contains a box with class "user_actions"

    Scenario: Logged user can see admin_profile box
        Given a session for the user "john@example.com"
        When I open "john@example.com" profile page
        Then the page contains a box with id "admin_profile"

    Scenario: Logged user can not admins others profile
        Given a session for the user "john@example.com"
        And a user with email: "jane@example.com"
        When I open "jane@example.com" profile page
        Then the page not contains a box with id "admin_profile"

    Scenario: Logged user can not add friend already added
        Given a session for the user "john@example.com"
        And a user with email "jane@example.com"
        And "john@example.com" is friend of "jane@example.com"
        When I open "jane@example.com" profile page
        Then the page not contains link with class "invitation"
