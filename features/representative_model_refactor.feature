Feature: Refactoring Legacy Code for civic_api_to_representative_params
  Background:
    Given there are representatives with the following details:
      | name        | ocdid         | title      |
      | ExistingRep | existing-ocdid | Existing   |  
  
  Scenario: Creating new representatives from Civic API response
    Given a Civic API response with the following officials:
      | Name          | OcdId      | Title    |
      | Harry Styles  | ocd-id-1   | Senator  |
      | Andrew Hozier | ocd-id-2   | Senator  |
      | Taylor Swift  | ocd-id-3   | Governor |
    When the method civic_api_to_representative_params is called with a Civic API response
    Then there should be new representatives created as follows:
      | name          | ocdid                  | title                |
      | Harry Styles  | ocd-id-1               | Senator              |
      | Andrew Hozier | ocd-id-2               | Senator              |
      | Taylor Swift  | ocd-id-3               | Governor             | 
  
  Scenario: Creating representative who exists
    Given a Civic API response with the following officials:
      | Name          |
      | ExistingRep   |
    When the method civic_api_to_representative_params is called with a Civic API response
    Then there should be no new representatives created