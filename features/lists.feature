
Feature: Users lists

    @last_registereds @last_accessed
    Scenario Outline: List order
        Given an anonymous session
        And the following users exists:
            | email             | <order_field> |
            | john@example.com  | 1970-01-01    |
            | jane@example.com  | 1970-01-02    |
        When I open <page> page
        Then the "profiles" box has this list:
            | john@example.com  |
            | jane@example.com  |

        Scenarios:
            | order_field       | page                      |
            | created_at        | profiles                  |
            | last_access_at    | profiles_last_accessed    |

    @tags
    Scenario: Users can be filtered by tags
        Given an anonymous session
        And the following users exists:
            | email             | tags      |
            | john@example.com  | foo, bar  |
            | jane@example.com  | foo       |
            | smith@example.com | bar       |
        When I open profiles page
        And I click in "foo" within the "tag-cloud" box
        Then I see this users:
            | john@example.com  |
            | jane@example.com  |

    @tags
    Scenario: Profiles page shows tag cloud
        Given: an anonymous session
        And the following users exists:
            | tags  |
            | foo   |
            | foo   |
            | bar   |
            | bar   |
            | baz   |
        When I go to profiles page
        Then I see the  "tab-cloud" box with this links:
            | foo   |
            | bar   |
            | baz   |

    Scenario: Users connected within 30 minutes
        Given an anonymous session
        And the following users exists:
            | email             | last_acess_at     |
            | john@example.com  | 12:00             |
            | jane@example.com  | 12:10             |
        And actual time is 12:35
        When I open profiles_connected page
        Then the "profiles" box has this list:
            | jane@example.com  |

    Scenario Outline: Users with determined prize
        Given an anonymous session
        And the following users exists:
            | email             | prize     |
            | john@example.com  | <prize>   |
            | jane@example.com  | nil       |
        When I open profiles <prize> prize page
        Then the "profiles" box has this list:
            | john@example.com  |

        Scenarios:
            | prize             |
            | entertainer       |
            | blogger           |
            | colaborator       |
            | distinguished     |
            | photographer      |
            | oficial_member    |
            | policeman         |
            | popular           |
