require 'rails_helper'

RSpec.describe "posts/show.html.erb", type: :view do
  let!(:moderator) { create :major_moderator }
  let!(:post_model) { create :post }
  let!(:comment) { create :comment, post: post_model, user: moderator }

  before(:each) do
    assign(:post, post_model)
  end
  describe 'show post_model fields' do
    it 'show info' do
      render
      expect(rendered).to match(post_model.title)
      expect(rendered).to match(post_model.sinopsis)
      expect(rendered).to match(post_model.body)
      expect(rendered).to match(post_model.impressions.to_s)
    end

    it 'show comments' do
      render
      expect(rendered).to match(post_model.comments.count.to_s)
    end
  end
end
