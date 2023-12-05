Feature: Making sure representative profile contains new information

  Scenario: Details are displayed on the representative profile page for a made up representative
    Given there is a representative named "Fake Representative"
    When I visit their representative profile page
    Then I should see the representative's name, address, political party, and photo