require 'rails_helper'

describe PostPolicy do

  let(:major_moderator) { create :major_moderator }
  let(:minor_moderator) { create :minor_moderator }
  let(:user)            { create :user }
  let(:maj_post)        { create :post, user: major_moderator }
  let(:min_post)        { create :post, user: minor_moderator }

  subject { described_class }

  shared_examples 'grants major and minor moderators' do
    it 'grants major_moderator' do
      expect(subject).to permit(major_moderator)
    end

    it 'grants minor_moderator' do
      expect(subject).to permit(minor_moderator)
    end

    it 'denies user' do
      expect(subject).not_to permit(user)
    end
  end

  shared_examples 'grants minor_mod to their posts' do
    it 'grants major_moderator to all posts' do
      expect(subject).to permit(major_moderator, maj_post)
      expect(subject).to permit(major_moderator, min_post)
    end

    it 'grants minor_moderator to edit his posts' do
      expect(subject).to permit(minor_moderator, min_post)
    end

    it 'denies minor_moderator to edit not his posts' do
      outher_minor_m = create :minor_moderator
      expect(subject).not_to permit(minor_moderator, maj_post)
      expect(subject).not_to permit(minor_moderator, create(:post, user: outher_minor_m))
    end

    it 'denies "user"' do
      expect(subject).not_to permit(user, maj_post)
      expect(subject).not_to permit(user, min_post)
    end
  end

  permissions :new? do
    it_behaves_like 'grants major and minor moderators'
  end

  permissions :edit? do
    it_behaves_like 'grants minor_mod to their posts'
  end

  permissions :create? do
    it_behaves_like 'grants major and minor moderators'
  end

  permissions :update? do
    it_behaves_like 'grants minor_mod to their posts'
  end

  permissions :destroy? do
    it_behaves_like 'grants minor_mod to their posts'
  end
end
