RSpec.describe "categories/newest", type: :view do
  it 'display category"s title' do
    post_model = create :post
    assign(:posts, [post_model])
    render
    expect(rendered).to match(post_model.title)
  end
end
