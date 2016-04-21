require 'rails_helper'

describe CommentPolicy do
  let(:major_moderator) { create :major_moderator }
  let(:minor_moderator) { create :minor_moderator }
  let(:user)            { create :user }
  let(:user_1)          { create :user }
  let(:comment)         { create :comment, user: user}

  subject { described_class }

  permissions :update? do
    it 'grants access major_moderator' do
      expect(subject).to permit(major_moderator, comment)
    end

    it 'grants access minor_moderator' do
      expect(subject).to permit(minor_moderator, comment)
    end

    it 'grants access user to their comment' do
      expect(subject).to permit(user, comment)
    end

    it 'denies access user to not their comment' do
      expect(subject).not_to permit(user_1, comment)
    end

  end

  permissions :destroy? do
    it 'grants access major_moderator' do
      expect(subject).to permit(major_moderator, comment)
    end

    it 'grants access minor_moderator' do
      expect(subject).to permit(minor_moderator, comment)
    end

    it 'grants access user to their comment' do
      expect(subject).to permit(user, comment)
    end

    it 'denies access user to not their comment' do
      expect(subject).not_to permit(user_1, comment)
    end
  end
end
