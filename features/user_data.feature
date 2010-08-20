
Feature: User data modification

  Scenario Outline: When a user changes email, it has to be valid and unique
    Given a session for the user "john@example.com"
    And a user exists with email: "jane@example.com"
    When I go to the account email page
    And I fill in "<email>" for "Email"
    And I submit the form
    Then these fields have errors: Email

    Scenarios:
      | email             |
      | onlyuser          |
      | foo@test          |
      | @cual.com         |
      | jane@example.com  |
      | JANE@example.com  |

  Scenario: Email changes has to be validated by email
    Given a session for the user "john@example.com"
    When I go to the account email page
    And I fill in "john.two@example.com" for "Email"
    And I submit the form
    Then an email was sent with subject: "Email address validation", to: "john.two@example.com"
    And the flash box contains "An email was sent to validate it."

  Scenario: After confirm a email change request the email is modified
    Given a user: "test" exists with email: "first@example.com", name: "Test user"
    And a change email request exists with key: "1234", new_email: "second@example.com", user: user "test"
    When I go to the validate email change page with id: "1234"
    Then the flash box contains "The address was validated. Your new email is second@example.com"
    And a user should exist with email: "second@example.com", name: "Test user"

  Scenario: Personal data can be modified using account settings page
    Given a session for the user "john@example.com"
    When I go to the account settings page
    And I fill in the following:
      | Name       | John              |
      | Surname    | Example           |
      | About      | foo               |
      | Hobbies    | Make funny things |
      | Postcode   | 00001             |
      | City       | Milan             |
      | Country    | Italy             |
      | Gtalk      | john@gmail.com    |
      | Skype      | johnskype         |
      | Website    | www.john.com      |
    And I select "1980-08-19" as the "Birth date" date
    And I click on "Male"
    And I submit the form
    Then a user should exist with name: "John", surname: "Example", birth_date: "1980-08-19", gender: "male", about: "foo", hobbies: "Make funny things", postcode: "00001", city: "Milan", country: "Italy", gtalk: "john@gmail.com", skype: "johnskype", website: "www.john.com"
    And the flash box contains "Your data has been updated."
