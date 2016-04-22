require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe '#to_markdown' do
    it 'convert md to html' do
      expect(helper.to_markdown('*rspec*')).to eq(Kramdown::Document.new('*rspec*').to_html)
    end

    it 'return all categories(sorted)' do
      category_1 = create :category, created_at: 3.days.ago
      category_2 = create :category, created_at: 2.days.ago
      expect(helper.all_categories).to eq([category_1, category_2])
    end
  end
end
