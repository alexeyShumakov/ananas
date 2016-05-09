require 'rails_helper'

describe HistoryPolicy do

  let(:major_moderator) { create :major_moderator }
  let(:minor_moderator) { create :minor_moderator }
  let(:user)            { create :user }
  let(:history)         { create :history, user: user }

  subject { described_class }

  permissions :update? do
    it 'grants access major_moderator' do
      expect(subject).to permit(major_moderator)
    end

    it 'grants access minor_moderator' do
      expect(subject).to permit(minor_moderator)
    end

    it 'denied access to user' do
      expect(subject).not_to permit(user)
    end
  end

  permissions :destroy? do
    it 'grants access major_moderator' do
      expect(subject).to permit(major_moderator)
    end

    it 'grants access minor_moderator' do
      expect(subject).to permit(minor_moderator)
    end
  end

  permissions :edit? do
    it 'grants access major_moderator' do
      expect(subject).to permit(major_moderator)
    end

    it 'grants access minor_moderator' do
      expect(subject).to permit(minor_moderator)
    end

    it 'denied access to user' do
      expect(subject).not_to permit(user)
    end
  end
end
