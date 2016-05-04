RSpec.describe "categories/newest", type: :view do
  it 'display category"s title' do
    post_model = create :post
    assign(:posts, Kaminari.paginate_array([post_model]).page(1))
    render
    expect(rendered).to match(post_model.title)
  end
end
