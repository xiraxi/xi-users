
Feature: Logout of the web

    Scenario: A logged user becomes anonymous after logout
        Given a session for the user "john@example.com"
        When I open user_logout page
        Then session is empty
