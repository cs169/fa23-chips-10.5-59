require 'rails_helper'
require 'spec_helper'

describe Event do
  describe 'timings' do
    it 'checks invalid start time' do
      county = County.create
      event = described_class.new(county: county, start_time: Time.zone.local(2022, 1, 1),
                                  end_time: Time.zone.local(2024, 1, 1))
      expect(event).not_to be_valid
    end
  end
end

describe Event do
  describe 'timings' do
    it 'checks invalid end time' do
      county = County.create
      event = described_class.new(county: county, start_time: Time.zone.local(2024, 1, 1),
                                  end_time: Time.zone.local(2022, 1, 1))
      expect(event).not_to be_valid
    end
  end
end
