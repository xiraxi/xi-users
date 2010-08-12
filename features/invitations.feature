
Feature: Invitations

    Scenario Outline: An anonymous user can not manage invitations
        Given  an anonymous session
        When I open <action> invitation page
        Then I see the forbidden page

        Scenarios:
            | action    |
            | new       |
            | index     |
            | accept    |
            | decline   |

    Scenario Outline: A user can not invite a friend
        Given a user exists with login: "john@example.com", password: "john"
        And a user exists with login: "smith@example.com"
        And the users "john@example.com" and "smith@example.com" are contacts
        And a session logged to "john:john"
        When I go to <action> page
        Then the page has no a "new contact" link withing "account actions" box

        Scenarios:
            | action                        |
            | profiles                      |
            | "smith@example.com" profile   |

    Scenario: A user can only see their invitations
        Given a session for the user "john@example.com"
        And a friend invitation from user "jane@example.com" to "john@example.com"
        When I open invitations page
        Then I see one "invitation" box
        And the "invitation" box contains "jane@example.com"
