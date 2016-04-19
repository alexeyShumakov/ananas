require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:user) { create :user }
  let!(:post_model) { create :post, user: user }
  describe "GET #show" do
    it "returns http success" do
      get :show, id: post_model.id
      expect(response).to have_http_status(:success)
    end

    it 'increase impressions value by 1' do
      impr = post_model.impressions
      get :show, id: post_model.id
      post_model.reload
      expect(assigns(:post)).to eq(post_model)
      expect(post_model.impressions).to eq(impr + 1)
    end

    it 'create new comment' do
      get :show, id: post_model.id
      expect(assigns(:comment)).to be_a(Comment)
    end
  end

  #describe "GET #edit" do
    #it "returns http success" do
      #get :edit
      #expect(response).to have_http_status(:success)
    #end
  #end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  #describe "GET #destroy" do
    #it "returns http success" do
      #get :destroy
      #expect(response).to have_http_status(:success)
    #end
  #end

  #describe "GET #update" do
    #it "returns http success" do
      #get :update
      #expect(response).to have_http_status(:success)
    #end
  #end

end
