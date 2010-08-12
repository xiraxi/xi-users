
Feature: Users lists

    @last_registereds @last_accessed
    Scenario Outline: List order
        Given an anonymous session
        And the following users exists:
            | email             | <order_field> |
            | john@example.com  | 01/01/1970    |
            | jane@example.com  | 01/02/1970    |
        When I open <page> page
        Then the "profiles" box has this list:
            | john@example.com  |
            | jane@example.com  |

        Scenarios:
            | order_field       | page                      |
            | created_at        | profiles                  |
            | last_access_at    | profiles_last_accessed    |

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
