Feature: Map Actions

  Scenario: Viewing the national map page
    Given I am on the map page
    Then I should see a map of the United States

  Scenario: Visiting a county map page
    Given I am on the "CA" state page
    When I click on Counties in California
    Then I should see "Alameda County"