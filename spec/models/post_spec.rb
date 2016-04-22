require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post_1) { create :post, impressions: 100 }
  let(:post_2) { create :post, impressions: 200 }
  let(:post_3) { create :post, impressions: 300 }

  it '#best_weekly' do
    post_4 = create :post, impressions: 10, created_at: 8.days.ago
    expect(Post.best_weekly).to match_array([post_3, post_2, post_1])
  end

  it 'limit array' do
    15.times { create :post }
    expect(Post.best_weekly.length).to eq(10)
  end
end
