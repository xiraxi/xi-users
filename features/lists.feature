
Feature: Users lists

    @last_registereds @last_accessed
    Scenario Outline: List order
        Given an anonymous session
        And the following users exist:
            | email            | name | <order>    |
            | john@example.com | John | 1990-01-01 |
            | jane@example.com | Jane | 1990-01-02 |
        When I go to the <page> page
        Then the "profiles" box has these boxes in the same order:
            | name | John  |
            | name | Jane  |

        Scenarios:
            | order          | page          |
            | created_at     | users         |
            | last_login_at  | recent users  |

    Scenario: Users connected within 30 minutes
        Given an anonymous session
        And the following users exist:
            | email            | name | last_login_at  |
            | john@example.com | John | 35 minutes ago |
            | jane@example.com | Jane | 25 minutes ago |
        When I go to the connected users page
        Then the "profiles" box does not contain "John"
        And the "profiles" box contains "Jane"

    Scenario: Every time the users log in its last acess timestamp is updated
        Given an anonymous session
        And the following users exist:
            | email            | password | name | last_login_at  |
            | john@example.com | test     | John | 10 minutes ago |
            | jane@example.com | test     | Jane | 1 day ago      |
        When I go to the page login 
        And I fill in the following:
            | email     | jane@example.com |
            | password  | test             |
        And I submit the form
        And I go to the connected users page
        Then the "profiles" box has these boxes in the same order:
            | name | Jane  |
            | name | John  |
