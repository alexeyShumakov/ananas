require 'rails_helper'

RSpec.describe "histories/edit", type: :view do
  before(:each) do
    @history = assign(:history, History.create!(
      :name => "MyString",
      :email => "MyString@email.com",
      :history => "MyText"
    ))
  end

  it "renders the edit history form" do
    render

    assert_select "form[action=?][method=?]", history_path(@history), "post" do

      assert_select "input#history_name[name=?]", "history[name]"

      assert_select "input#history_email[name=?]", "history[email]"

      assert_select "textarea#history_history[name=?]", "history[history]"
    end
  end
end
