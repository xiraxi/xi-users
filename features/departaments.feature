
Feature: Departaments

    Scenario Outline: CU for departaments only for admin
        Given a not admin session
        When I open <action>
        Then I see the forbidden page

        Scenarios:
            | action    |
            | index     |
            | new       |
            | edit      |

    Scenario Outline: RD for departaments not available
        Given any session
        When I open <action>
        Then I see the nor found page

        Scenarios:
            | action    |
            | show      |
            | delete    |

    Scenario: Index shows "name" and "order"
        Given an admin session
        When I open index departaments page
        Then the page contains this boxes within "crud-index":
            | id            |
            | item_name     |
            | item_order    |

    Scenario: Admin can create new departaments
        Given an admin session
        When I open new departament page
        And I fill the "basic-crud" form with:
            | name  | foo   |
            | order | 1     |
        And I submit the form
        Then I see the index departament page
        And the flash box contains "Successfully created"
        And the page containd this boxes within "crud-index"
            | name  | foo   |
            | order | 1     |

    Scenario: Admin can edit a departament
        Given an admin session
        And a departament with name: "foo", order: "1"
        When I open edit departament page
        And I fill the "basic-crud" form with:
            | name  | bar   |
            | order | 0     |
        Then I see the index departament page
        And the flash box contains "Successfully created"
        And the page containd this boxes within "crud-index"
            | name  | bar   |
            | order | 0     |

    Scenario: departaments can not be empty
        Given an admin session
        When I go to new departament page
        And I submit the "basic-crud" form
        Then these fields have errors: name, order

    Scenario: unused departaments can be removed
        Given an admin session
        And the following departaments exist:
            | name  |
            | Red   |
            | Blue  |
        And a user exists with departament: "Blue"
        When I go to departaments page
        And I click on "Remove this departament" within "Red" departament box
        Then the flash box contains "Departament has been removed."
        And there are 1 departament instances with name: "Blue"

    Scenario: used departaments can not be removed
        Given an admin session
        And a departament with name: "Main"
        And a user exists with departament: "Main"
        When I go to departaments page
        And I click on "Remove this departament"
        Then the flash box contains "Departament can not be removed because it is used by almost 1 user."
        And a departament should exist with name: "Main"

