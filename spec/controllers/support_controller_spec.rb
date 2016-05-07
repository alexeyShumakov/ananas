require 'rails_helper'

RSpec.describe SupportController, type: :controller do

  describe "GET #about" do
    it "returns http success" do
      get :about
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #partner" do
    it "returns http success" do
      get :partner
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #ads" do
    it "returns http success" do
      get :ads
      expect(response).to have_http_status(:success)
    end
  end

end
