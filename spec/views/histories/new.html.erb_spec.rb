require 'rails_helper'

RSpec.describe "histories/new", type: :view do
  before(:each) do
    sign_in create(:user)
    assign(:history, History.new(
      :title => "MyString",
      :history => "MyText"
    ))
  end

  it "renders new history form" do
    render

    assert_select "form[action=?][method=?]", histories_path, "post" do

      assert_select "input#history_title[name=?]", "history[title]"

      assert_select "textarea#history_history[name=?]", "history[history]"
    end
  end
end
