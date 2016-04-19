require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  describe '#to_markdown' do
    it 'convert md to html' do
      expect(helper.to_markdown('*rspec*')).to eq(Kramdown::Document.new('*rspec*').to_html)
    end
  end
end
