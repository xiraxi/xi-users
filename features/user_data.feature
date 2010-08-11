
Feature: User data modification

    Scenario Outline: When a user changes email, it has to be valid and unique
        Given a session for the user "john@example.com"
        And a user with email "jane@example.com"
        When I open comunity_prefs page
        And fill the form named "email_change" with:
            | email | <email>   |
        And submit the form
        Then the form field "email" has an error

        Scenarios:
            | email             |
            | onlyuser          |
            | foo@test          |
            | @cual.com         |
            | john@example.com  |
            | jane@example.com  |

    Scenario: Email change is complemented
        Given a session for the user "john@example.com"
        When I open comunity_prefs page
        And fill the form named "email_change" with:
            | email | john2@example.com  |
        And submit the form
        Then a email_change for the user john@example.com is created
        And an email with subject "Cambio de email" is sent

    Scenario: Email change confirmation
        Given a user exists with email: "foo@tal.com"
        And a email_change request exist with key: "1234", new email: "bar@cual.com"
        When I go to email_change page with key: "1234"
        Then user has email "bar@cual.com"

    Scenario: Anonymous user can not see personal prefs page
        Given an anonymous user
        When I open personal_prefs page
        Then I see the forbidden page

    Scenario: Logged user see personal prefs form
        Given a session for the user "john@example.com"
        When I open personal_prefs page
        And fill the "prefs" form with:
            | name              | John              |
            | surname           | Example           |
            | born              | 01/01/1970        |
            | gender            | male              |
            | profession        | programmer        |
            | profile           | foo               |
            | hobbies           | bar               |
            | tags              | foo, bar          |
            | city              | new york          |
            | postal_code       | 00001             |
            | country_id        | 1                 |
            | region_id         | 2                 |
            | msn_messenger     | john@msn.com      |
            | yahoo_messenger   | john@yahoo.com    |
            | gtalk             | john@gmail.com    |
            | skype             | john@skype.com    |
            | web               | www.john.com      |
            | show_public_email | true              |
            | twitter_rss       | twitter_john      |
        And submit the form
        Then user "john@example.com" has name: "John", surname: "Example", born: "01/01/10970", gender: "male", profession: "programmer", profile: "foo", hobbies: "bar", city: "new york", postal_code: "00001", country_id: "1", region_id: "2", msn_messenger: "john@msn.com", yahoo_messenger: "john@yahoo.com", gtalk: "john@gmail.com", skype: "john@skype.com", web: "www.john.com", show_public_email: true, twitter_rss: "twitter_john"

    Scenario: Anonymous user can not see comunity prefs page
        Given an anonymous user
        When I open comunity_prefs page
        Then I see the forbidden page

    Scenario: Anonymous user can not see professional prefs page
        Given an anonymous user
        When I open professional_prefs page
        Then I see the forbidden page

    Scenario: Logged user can not see professional if not activated
        Given a session for user "john@example.com"
        And professional fields are not activated
        When I open professional_prefs page
        Then I see the forbidden page

    Scenario: Logged user see professional prefs form if activated
        Given a session for user "john@example.com"
        And professional fields are activated
        When I open professional_prefs page
        And fill the prefs form with:
            | company                   | Socialtec         |
            | company_description       | Lorem             |
            | company_city              | Foo               |
            | company_province          | Bar               |
            | company_email             | fake@company.com  |
            | company_position          | King              |
            | company_employee_num      | 10                |
            | company_departament_id    | 1                 |
            | company_departament_other | Fake_dep          |
            | company_sector_id         | 1                 |
            | company_sector_other      | Fake_sec          |
        And submit the form
        Then user "john@example.com" has  company: "Socialtec", company_description: "Lorem", company_city: "Foo", company_province: "Bar", company_email: "fake@company.com", company_position: "King", company_employee_num: "10", company_departament_id: "1", company_departament_other: "Fake_dep", company_sector_id: "1", company_sector_other: "Fake_sec"
