require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  it 'checks name and auth provider' do
    user = User.create(uid: 1, provider: 'github')
    expect(user.name).to eq(' ')
    expect(user.auth_provider).to eq('Github')
    expect(described_class.find_github_user(1)).to eq(user)

    user2 = User.create(uid: 2, provider: 'google_oauth2')
    expect(user2.auth_provider).to eq('Google')
    expect(described_class.find_google_user(2)).to eq(user2)
  end
end
