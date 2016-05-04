require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do
  let(:user) { create :user }
  let(:post_model) { create :post}
  before(:each) do
    sign_in user
  end
  describe "#post create" do

    it 'assigns favorite' do
      post :create, favorite: {post_id: post_model.id}
      expect(assigns(:favorite)).to be_a(Favorite)
    end

    it 'assigns post' do
      post :create, favorite: {post_id: post_model.id}
      expect(assigns(:post)).to eq(post_model)
    end

    it 'create new favorite' do
        expect { post :create, favorite: {post_id: post_model.id}}.to change(Favorite, :count).by(1)
    end

    it 'destroy favorite if it exist' do
      create :favorite, post_id: post_model.id, user_id: user.id
        expect { post :create, favorite: {post_id: post_model.id}}.to change(Favorite, :count).by(-1)
    end

  end

end
