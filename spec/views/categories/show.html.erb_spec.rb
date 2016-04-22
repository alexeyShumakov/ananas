require 'rails_helper'

RSpec.describe "categories/show", type: :view do
  let(:category) { create :category }
  it 'display category"s title' do
    assign(:category, category)
    render
    expect(rendered).to match(category.title)
  end

  it 'display post information' do
    post_model = create :post, category: category
    assign(:category, category)
    render
    expect(rendered).to match(post_model.title)
    expect(rendered).to match(post_model.sinopsis)
  end

  it 'display user information' do
    post_model = create :post, category: category
    assign(:category, category)
    render
    expect(rendered).to match(post_model.user.email)
  end
end
