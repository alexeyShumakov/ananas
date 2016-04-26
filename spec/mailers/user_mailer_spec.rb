require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }
  let(:post_model) { create(:post) }
  let(:mail) { UserMailer.best_weekly(user) }
  describe '#best_weekly' do
    it 'should have access to URL helpers' do
      expect { post_url(post_model.id, host: 'example.com') }.not_to raise_error
    end

    it 'rignt to email' do
      expect(mail.to).to eq([user.email])
    end

    it 'have subject' do
      expect(mail.subject).to eq('Ананас. Лучшее за неделю.')
    end
  end

end
