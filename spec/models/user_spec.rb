require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#owner_of?' do
    let(:user) { create :user }
    it 'return true' do
      post = create :post, user: user
      expect(user.owner_of?(post)).to be_truthy
    end

    it 'return false' do
      post = create :post
      expect(user.owner_of?(post)).to be_falsey
    end
  end
end
