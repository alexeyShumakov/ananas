require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:user) { create :major_moderator }
  let(:category) { create :category }
  let!(:post_model) { create :post, user: user, category: category }
  before(:each) do
    sign_in user
  end

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

  describe "GET #edit" do
    it "returns http success" do
      get :edit, id: post_model.id
      expect(response).to have_http_status(:success)
    end

    it 'assigns @post' do
      get :edit, id: post_model.id
      expect(assigns(:post)).to eq(post_model)
    end

    it 'assigns @categories' do
      get :edit, id: post_model.id
      expect(assigns(:categories)).to eq([category])
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it 'assigns @post' do
      get :new
      expect(assigns(:post)).to be_a(Post)
    end

    it 'assigns @categories' do
      get :new
      expect(assigns(:categories)).to eq([category])
    end
  end

  describe "DELETE #destroy" do
    it "destroy post model" do
      expect { delete :destroy, id: post_model.id }.to change(Post, :count).by(-1)
    end

    it 'redirect_to root' do
      delete :destroy, id: post_model.id
      expect(request).to redirect_to(root_path)
    end
  end

  describe "POST #create" do
    describe 'with valid params' do
      it "create new post" do
        sign_in user
        expect { post :create, post: attributes_for(:post, category_id: category.id) }.to change(Post, :count).by(1)
      end

      it 'redirect to post' do
        sign_in user
        post :create, post: attributes_for(:post, category_id: category.id)
        expect(request).to redirect_to(post_path(assigns(:post).id))
      end
    end

    describe 'with invalid params' do
      it 'render edit template' do
        sign_in user
        post :create, post: attributes_for(:post, category_id: nil)
        expect(response).to render_template(:edit)
      end

      it 'not save model' do
        sign_in user
        expect { post :create, post: attributes_for(:post, category_id: nil) }.to change(Post, :count).by(0)
      end

      it 'assigns post model' do
        post :create, post: attributes_for(:post, category_id: nil)
        expect(assigns(:post)).to be_a(Post)
      end
    end
  end

  describe 'PATCH #update' do
    describe 'with valid params' do
      it 'update params' do
        patch :update, id: post_model.id, post: attributes_for(:post, category_id: category.id, title: 'new title')
        post_model.reload
        expect(post_model.title).to eq('new title')
      end

      it 'assign post model' do
        patch :update, id: post_model.id, post: attributes_for(:post, category_id: category.id, title: 'new title')
        post_model.reload
        expect(assigns(:post)).to eq(post_model)
      end

      it 'redirect to updated post' do
        patch :update, id: post_model.id, post: attributes_for(:post, category_id: category.id, title: 'new title')
        expect(request).to redirect_to(post_path(post_model.id))
      end
    end

    describe 'with invalid params' do
      it 'render edit template' do
        patch :update, id: post_model.id, post: attributes_for(:post, category_id: nil)
        expect(response).to render_template(:edit)
      end
    end
  end

end
