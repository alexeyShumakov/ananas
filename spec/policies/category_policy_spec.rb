require 'rails_helper'

describe CategoryPolicy do
  let(:major_moderator) { create :major_moderator }
  let(:minor_moderator) { create :minor_moderator }
  let(:user)            { create :user }
  let(:category)        { create :category }

  shared_examples "grants major_moderator" do
    it 'grants access if user major_moderator' do
      expect(subject).to permit(major_moderator, category)
    end

    it 'denies access if user have "user" role' do
      expect(subject).not_to permit(user, category)
    end

    it 'denies access if user have "minor_moderator" role' do
      expect(subject).not_to permit(minor_moderator, category)
    end
  end


  subject { described_class }

  permissions :new? do
    it_behaves_like 'grants major_moderator'
  end

  permissions :edit? do
    it_behaves_like 'grants major_moderator'
  end

  permissions :create? do
    it_behaves_like 'grants major_moderator'
  end

  permissions :update? do
    it_behaves_like 'grants major_moderator'
  end

  permissions :destroy? do
    it_behaves_like 'grants major_moderator'
  end
end
