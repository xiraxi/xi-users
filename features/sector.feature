
Feature: Sectors

    Scenario Outline: CU for sectors only for admin
        Given a non admin session
        When I open <action>
        Then I see the forbidden page

        Scenarios:
            | action    |
            | index     |
            | new       |
            | edit      |

    Scenario Outline: RD for sectors not available
        Given any session
        When I open <action>
        Then I see the not found page

        Scenarios:
            | action    |
            | show      |
            | delete    |

    Scenario: Index shows "name" and "order"
        Given an admin session
        When I open index sectors page
        Then the page contains these boxes within "crud-index":
            | id            |
            | item_name     |
            | item_order    |

    Scenario: Admin can create new sectors
        Given an admin session
        When I open new sector page
        And I fill the "basic-crud" form with:
            | name  | foo   |
            | order | 1     |
        And I submit the form
        Then I see the index sector page
        And the flash box contains "Successfully created"
        And the page contains these boxes within "crud-index"
            | name  | foo   |
            | order | 1     |

    Scenario: Admin can edit a sector
        Given an admin session
        And a sector with name: "foo", order: "1"
        When I open edit sector page
        And I fill the "basic-crud" form with:
            | name  | bar   |
            | order | 0     |
        Then I see the index sector page
        And the flash box contains "Successfully created"
        And the page contains these boxes within "crud-index"
            | name  | bar   |
            | order | 0     |

    Scenario: sectors can not be empty
        Given an admin session
        When I go to new sector page
        And I submit the "basic-crud" form
        Then these fields have errors: name, order

    Scenario: unused sectors can be removed
        Given an admin session
        And the following sectors exist:
            | name  |
            | Red   |
            | Blue  |
        And a user exists with sector: "Blue"
        When I go to sectors page
        And I click on "Remove this sector" within "Red" sector box
        Then the flash box contains "Departament has been removed."
        And there are 1 sector instances with name: "Blue"

    Scenario: used sectors can not be removed
        Given an admin session
        And a sector with name: "Main"
        And a user exists with sector: "Main"
        When I go to sectors page
        And I click on "Remove this sector"
        Then the flash box contains "Departament can not be removed because it is used by almost 1 user."
        And a sector should exist with name: "Main"

