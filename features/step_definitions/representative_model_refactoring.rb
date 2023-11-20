Given(/^there are representatives with the following details:$/) do |table|
  table.hashes.each do |rep_info|
    Representative.create!(rep_info)
  end
end

Given(/^a Civic API response with the following officials:$/) do |table|
  @civic_api_response = OpenStruct.new(
    officials: table.hashes.map do |row|
      OpenStruct.new(
        'name' => row['Name'],
        'ocdid' => row['OcdId'],
        'title' => row['Title']
      )
    end,
    offices: table.hashes.map.with_index do |row, index|
      {
        'division_id' => row['OcdId'],
        'name' => row['Title'],
        'official_indices' => [index]
      }
    end
  )
end


When(/^the method civic_api_to_representative_params is called with a Civic API response$/) do
  @created_representatives = Representative.civic_api_to_representative_params(@civic_api_response)
end

Then(/^there should be new representatives created as follows:$/) do |expected_table|
  # Iterate over the rows in the expected table
  expected_table.hashes.each_with_index do |expected_row, index|
    # Access the actual row in the returned array
    actual_row = @created_representatives[index]

    # Debugging statements
    puts "Expected Row: #{expected_row}"
    puts "Actual Row: #{actual_row}"

    # Compare each field in the row
    expected_row.each do |field, expected_value|
      actual_value = actual_row[field]

      # Debugging statements
      puts "Field: #{field}, Expected: #{expected_value}, Actual: #{actual_value}"

      expect(actual_value).to eq(expected_value)
    end
  end
end

Then(/^there should be no new representatives created$/) do
  expect(@created_representatives).to be_empty
end