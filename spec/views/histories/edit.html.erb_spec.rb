require 'rails_helper'

RSpec.describe "histories/edit", type: :view do
  before(:each) do
    @history = assign(:history, History.create!(
      :title => "MyString",
      :history => "MyText"
    ))
  end

  it "renders the edit history form" do
    render

    assert_select "form[action=?][method=?]", history_path(@history), "post" do

      assert_select "input#history_title[name=?]", "history[title]"

      assert_select "textarea#history_history[name=?]", "history[history]"
    end
  end
end
