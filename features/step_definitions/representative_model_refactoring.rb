Given(/^there are representatives with the following details:$/) do |table|
  table.hashes.each { |rep_info| Representative.create!(rep_info) }
end

Given(/^a Civic API response with the following officials:$/) do |table|
  @civic_api_response = OpenStruct.new(
    officials: table.hashes.map do |row|
      OpenStruct.new(
        'name' => row['name'],
        'ocdid' => row['ocdid'],
        'title' => row['title']
      )
    end,
    offices: table.hashes.map.with_index do |row, index|
      {
        'division_id' => row['ocdid'],
        'name' => row['title'],
        'official_indices' => [index]
      }
    end
  )
end

When(/^the method civic_api_to_representative_params is called with a Civic API response$/) do
  @created_representatives = Representative.civic_api_to_representative_params(@civic_api_response)
end

Then(/^there should be new representatives created as follows:$/) do |expected_table|
  expected_table.hashes.each_with_index do |expected_row, index|
    actual_row = @created_representatives[index]

    expected_row.each do |field, expected_value|
      actual_value = actual_row[field]

      expect(actual_value).to eq(expected_value)
    end
  end
end

Then("there should be no new representatives created") do
  expect(Representative.count).to eq(1)
end