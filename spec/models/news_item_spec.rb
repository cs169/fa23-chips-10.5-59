require 'rails_helper'
require 'spec_helper'

describe NewsItem do
  describe 'find for function' do
    it 'find rep in news item' do
      rep = Representative.create
      news = described_class.new(representative: rep, title: 'Test', link: 'http://test.com')

      expect(nil).to eq(described_class.find_for(rep.id))
    end
  end
end

describe NewsItem do
  describe 'find for function' do
    it 'find rep in news item' do
      rep = Representative.create
      expect(described_class.find_for(rep.id)).to eq(nil)
    end
  end
end