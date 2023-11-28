Given("I am on the map page") do
  visit root_path
end
    
Then("I should see a map of the United States") do
  expect(page).to have_css('svg#actionmap-national-view')
end

Given("I am on the 'CA' state page") 
  visit "state/#california"
end

When("I click on Counties in California") do 
  page.find(:css, '#actionmap-counties-details-header > h3 > button').click
end

Then("I should see 'Orange County'")
if page.respond_to?(:should)
  expect(page)
end

 
    # Given I am on the "NY" state page
    # When I click on Counties in New York
    # Then I should see "New York County"
    # When I click the New York County view button
    # Then I should be on New York County Representatives page
    # Then I should see "Table of Representatives"
    # And I should see "New York County"
    # And I should see "Alexandria Ocasio-Cortez"
    # And I should not see "Hamilton County"
