require 'rails_helper'

RSpec.describe "categories/show", type: :view do
  let(:category) { create :category }
  let(:post_model) { create(:post, category: category) }
  before(:each) do
    assign(:category, category)
    assign(:posts, Kaminari.paginate_array([post_model]).page(1))
  end
  it 'display category"s title' do
    render
    expect(rendered).to match(category.title)
  end

  it 'display post information' do
    render
    expect(rendered).to match(post_model.title)
    expect(rendered).to match(post_model.sinopsis)
  end

  it 'display user information' do
    render
    expect(rendered).to match(post_model.user.username)
  end
end
