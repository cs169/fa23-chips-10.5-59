require 'rails_helper'
require 'spec_helper'

describe Representative do
  describe 'api rep params' do
    it 'converts api to rep params' do
      rep = Representative.create(:name => "John Smith")
      rep_info = {"officials" => [rep, "yes"], "offices" => [{"officialIndices" => ["yes"], "name" => "John Smith", "divisionId" => 1}] }
      params = described_class.civic_api_to_representative_params(rep_info)
      expect(rep).to be_valid
    end
  end
end
