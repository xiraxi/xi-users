
Feature: User profiles

    Scenario: An anonymous user can not modify a user account
        Given an anonymous session
        And a user exists with email: "john@example.com", name: "John Smith"
        When I go to the users page
        And I click on "John Smith"
        Then the current page is a "show" action
        And the page does not contain the "user actions" box

    Scenario: Logged user can not do actions to herself
        Given a user exists with email: "john@example.com", name: "John Smith"
        And a session for the user "john@example.com"
        When I go to the users page
        And I click on "John Smith"
        Then the current page is a "show" action
        And the page does not contain the "user actions" box

    Scenario: Users can manage its account
        Given a user exists with email: "john@example.com", name: "John Smith"
        And a session for the user "john@example.com"
        When I go to the users page
        And I click on "John Smith"
        Then the current page is a "show" action
        And the page contains the "account management" box

    Scenario: Logged user can not manage others profile
        Given a user exists with email: "john@example.com", name: "John Smith"
        And a user exists with name: "Jane Thomson"
        And a session for the user "john@example.com"
        When I go to the users page
        And I click on "Jane Thomson"
        Then the current page is a "show" action
        And the page does not contain the "account management" box
