require 'rails_helper'

RSpec.describe "categories/new", type: :view do
  let(:category) { build :category }

  it 'display category"s title' do
    assign(:category, category)
    render
    expect(rendered).to match(category.title)
  end
end
