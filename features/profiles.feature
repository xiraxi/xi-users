
Feature: User profiles

    Scenario: An anonymous user can only view others profile
        Given an anonymous user
        And a user with email: "john@example.com"
        When I open "john@example.com" profile page
        Then the page does not contain a box with class "user_actions"

    Scenario: Logged user can not do actions to herself
        Given a session for the user "john@example.com"
        When I open "john@example.com" profile page
        Then the page does not contain a box with class "user_actions"

    Scenario: Logged user can see admin_profile box
        Given a session for the user "john@example.com"
        When I open "john@example.com" profile page
        Then the page contains a box with id "admin_profile"

    Scenario: Logged user can not manage others profile
        Given a session for the user "john@example.com"
        And a user with email: "jane@example.com"
        When I open "jane@example.com" profile page
        Then the page does not contain a box with id "admin_profile"

    Scenario: Logged user can not add contact already added
        Given a session for the user "john@example.com"
        And a user with email "jane@example.com"
        And "john@example.com" is contact of "jane@example.com"
        When I open "jane@example.com" profile page
        Then the page does not contain link with class "invitation"

    Scenario: When visiting profile, visit time is registered
        Given a session for the user "john@example.com"
        And a user with email "jane@example.com"
        And "john@example.com" is contact of "jane@example.com"
        When I open "jane@example.com" profile page
        Then field "visited_at" of user with email: "jane@example.com" is actualized with actual time 
