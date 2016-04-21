require 'rails_helper'


RSpec.describe CategoriesController, type: :controller do
  let!(:category) { create :category }

  describe "GET #show" do
    it 'assigns @category' do
      get :show, id: category.id
      expect(assigns :category).to eq(category)
    end
  end

  describe 'GET #newest' do
    let(:user) { create :user }
    let!(:post_model_1) { create :post, user: user }
    let!(:post_model_2) { create :post, user: user }
    it 'assigns last posts' do
      get :newest
      expect(assigns(:posts)).to eq([post_model_2, post_model_1])
    end
  end

  describe 'GET #new' do
    it 'assigns new category model' do
      get :new
      expect(assigns(:category)).to be_a(Category)
    end
  end

  describe 'POST #create' do
    describe 'with valid params' do
      it 'create new category' do
        expect { post :create, category: attributes_for(:category) }.to change(Category, :count).by(1)
      end

      it 'redirect to created category' do
        post :create, category: attributes_for(:category)
        expect(request).to redirect_to(assigns(:category))
      end
    end

    describe 'with invalid params' do
      let(:invalid_attrs) { attributes_for(:invalid_category) }
      it 'render edit template' do
        post :create, category: invalid_attrs
        expect(response).to render_template(:edit)
      end

      it 'have validation errors' do
        post :create, category: invalid_attrs
        expect(assigns(:category)).to be_invalid
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns category' do
      get :edit, id: category.id
      expect(assigns(:category)).to eq(category)
    end
  end

  describe 'PATCH #update' do
    let(:new_attrs) { attributes_for(:new_category) }

    describe 'with valid params' do
      it 'change category' do
        patch :update, id: category.id, category: new_attrs
        category.reload
        expect(category.title).to eq(new_attrs[:title])
      end

      it 'redirect to created category' do
        patch :update, id: category.id, category: new_attrs
        expect(response).to redirect_to(category)
      end
    end

    describe 'with invalid params' do
      let(:invalid_attrs) { attributes_for(:invalid_category) }
      it 'render edit template' do
        patch :update, id: category.id, category: invalid_attrs
        expect(response).to render_template(:edit)
      end

      it 'have validation errors' do
        patch :update, id: category.id, category: invalid_attrs
        expect(assigns(:category)).to be_invalid
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'delete category' do
      expect { delete :destroy, id: category.id}.to change(Category, :count).by(-1)
    end

    it 'delete category"s post' do
      create :post, category: category
      expect { delete :destroy, id: category.id}.to change(Post, :count).by(-1)
    end

    it 'redirect_to root_path' do
      delete :destroy, id: category.id
      expect(response).to redirect_to(root_path)
    end
  end

end
