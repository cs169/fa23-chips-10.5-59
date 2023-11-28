Feature: Map Actions

  Scenario: Viewing the national map page
    Given I am on the map page
    Then I should see a map of the United States

  Scenario: Visiting a county map page
    Given I am on the "CA" state page
    When I click on Counties in California
    Then I should see "Alameda County"

  Scenario: Visiting representatives
    Given I am on the "NY" state page
    When I click on Counties in New York
    Then I should see "New York County"
    When I click the New York County view button
    Then I should be on New York County Representatives page
    Then I should see "Table of Representatives"
    And I should see "New York County"
    And I should see "Alexandria Ocasio-Cortez"
    And I should not see "Hamilton County"
