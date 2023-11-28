require 'rails_helper'
require 'spec_helper'

describe User do
  describe 'name and auth provider' do
    it 'checks name and auth provider' do
      user = User.create(name: 'John Smith', auth: 'GitHub')
      user2 = User.create(name: 'Jane Smith', auth: 'Google')
      expect(user).to be_valid
      expect(described_class.find_google_user(999)).to eq(nil)
      expect(described_class.find_github_user(999)).to eq(nil)
    end
  end
end
