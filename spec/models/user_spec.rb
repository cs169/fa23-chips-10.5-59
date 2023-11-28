require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  it 'checks name and auth provider' do
    user = User.create(username: 'John Smith', auth: 'GitHub')

    expect(user.username).to eq('John Smith')
    expect(user.auth).to eq('GitHub')
  end
end
