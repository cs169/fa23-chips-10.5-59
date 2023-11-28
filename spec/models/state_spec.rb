require 'rails_helper'
require 'spec_helper'

describe State do
  describe 'std_fips_code' do
    it 'return standard fips code' do
      expect(described_class.new(fips_code: 06).std_fips_code).to eq('06')
    end
  end
end