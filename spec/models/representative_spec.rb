require 'rails_helper'
require 'spec_helper'

describe Representative do
  describe 'api rep params' do
    it 'converts api to rep params' do
      rep = Representative.create
      params = described_class.civic_api_to_representative_params(rep)
      expect(rep).to be_valid
    end
  end
end