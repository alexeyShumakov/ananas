require 'rails_helper'

describe UserPolicy do

  let(:user) { create :user }
  let(:minor_moderator) { create :minor_moderator }
  let(:major_moderator) { create :major_moderator }

  subject { described_class }


  permissions :update? do
    it 'grants access major_moderator' do
      expect(subject).to permit(major_moderator, user)
    end

    it 'denies access user and minor_moderator' do
      expect(subject).not_to permit(user, user)
      expect(subject).not_to permit(user, minor_moderator)
    end
  end

  permissions :search? do
    it 'grants access major_moderator' do
      expect(subject).to permit(major_moderator, user)
    end

    it 'denies access user and minor_moderator' do
      expect(subject).not_to permit(user, user)
      expect(subject).not_to permit(user, minor_moderator)
    end
    
  end

  permissions :moderator_panel? do
    it 'grants access major_moderator and minor_moderator' do
      expect(subject).to permit(major_moderator, user)
      expect(subject).not_to permit(user, minor_moderator)
    end

    it 'denies access user' do
      expect(subject).not_to permit(user, user)
    end
    
  end
end
