require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create :user }
  let(:comment) { create :comment, user: user }

  describe '#has_liked?' do
    it 'true if comment is liked by user' do
      create :like, user: user, comment: comment
      expect(comment.has_liked?(user)).to eq(true)
    end

    it 'return false if comment dont liked by user' do
      expect(comment.has_liked?(user)).to eq(false)
    end
  end
end
