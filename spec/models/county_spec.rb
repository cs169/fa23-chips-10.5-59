require 'rails_helper'
require 'spec_helper'

describe County do
  describe 'std_fips_code' do
    it 'return standard fips code' do
      expect(described_class.new(fips_code: 1).std_fips_code).to eq('001')
    end
  end
end

describe County do
  describe 'std_fips_code' do
    it 'return standard fips code' do
      expect(described_class.new(fips_code: 2).std_fips_code).to eq('002')
    end
  end
end

describe County do
  describe 'std_fips_code' do
    it 'return standard fips code' do
      expect(described_class.new(fips_code: 3).std_fips_code).to eq('003')
    end
  end
end