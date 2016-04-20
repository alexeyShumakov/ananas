require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #private_office" do
    it "returns http success" do
      get :private_office
      expect(response).to have_http_status(:success)
    end
  end

end
