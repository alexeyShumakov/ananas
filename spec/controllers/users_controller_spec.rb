require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create :major_moderator }
  before(:each) do
    sign_in user
  end

  describe "GET #private_office" do
    it "returns http success" do
      get :private_office
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #search" do
    it "returns http success" do
      get :search
      expect(response).to have_http_status(:success)
    end

    it "return user by keyword" do
      get :search, keyword: user.email
      expect(assigns(:users)).to eq([user])

    end
  end

  describe "PATCH #profile" do
    it 'update with valid params' do
      patch :profile, user: { username: 'new nickname'}
      user.reload
      expect(user.username).to eq('new nickname')
    end
    it 'not update if params are not valid' do
      patch :profile, user: { username: ''}
      user.reload
      expect(user.username).not_to eq('')
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PUT #update" do
    it 'cant update if user != major_moderator' do
      sign_in create(:user)
      put :update, { id: user.id, user: {role: :major_moderator} }
      expect(response).to have_http_status(302)
    end

    it 'update with valid params' do
      put :update, { id: user.id, user: {role: :major_moderator} }
      user.reload
      expect(assigns(:user)).to eq(user)
    end
    it 'not update with invalid params' do
      put :update, { id: user.id, user: {username: ''} }
      user.reload
      expect(assigns(:user)).to eq(user)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

end
