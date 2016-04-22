require 'rails_helper'

RSpec.describe "categories/edit", type: :view do
  let(:category) { create :category }

  it 'display category"s title' do
    assign(:category, category)
    render
    expect(rendered).to match(category.title)
  end
end
