require 'rails_helper'

RSpec.describe "histories/show", type: :view do
  before(:each) do
    @history = assign(:history, History.create!(
      :name => "Name",
      :email => "Email@email.com",
      :history => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email@email.com/)
    expect(rendered).to match(/MyText/)
  end
end
