
Feature: Geonames

    Scenario: Countries must be present
        Given a Xiraxi application
        When I load application
        Then Countries is not empty

    Scenario: Regions must be present
        Given a Xiraxi application
        When I load application
        Then Regions is not empty

    Scenario: Region must belongs to a country
        Given a region
        When I access region country
        Then country must be present
