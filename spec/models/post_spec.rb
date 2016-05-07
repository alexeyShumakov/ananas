require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:category) { create :category }
  let!(:post_1) { create :post, impressions: 100, category: category }
  let!(:post_2) { create :post, impressions: 200, category: category }
  let!(:post_3) { create :post, impressions: 300, category: category }

  it '#best_weekly' do
    post_4 = create :post, impressions: 10, created_at: 8.days.ago
    expect(Post.best_weekly).to match_array([post_3, post_2, post_1])
  end

  it 'limit array' do
    15.times { create :post }
    expect(Post.best_weekly.length).to eq(10)
  end

  describe '#has_favirite?' do
    let (:user) {create :user}
    it 'true if post favorite' do
      create :favorite, user: user, post: post_1
      expect(post_1.has_favorite?(user)).to eq(true)
    end
    it 'false if post not favorite' do
      expect(post_1.has_favorite?(user)).to eq(false)
    end
  end

  describe '#similar' do
    it 'test' do
      expect(post_1.similar.length).to eq(2)
    end
  end
end
