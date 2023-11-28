Given(/^there is a representative named {string}/) do |name|
  #create a nonexistent rep
  Representative.create!(name: name, ocdid: 'fake_ocdid', title: 'fake_title')
end


When(/^I visit their representative profile page/) do
  #visit the rep profile page, get first representative
  visit representative_path(Representative.first)

end


Then(/^I should see the representative's name, address, political party, and photo/)
  expect(page).to have_content(Representative.first.name)
  expect(page).to have_content(Representative.first.address)
  expect(page).to have_content(Representative.first.political_party)
  #not sure about line below 
  expect(page).to have_selector("img[src$='#{Representative.first.photoUrl}']")
end