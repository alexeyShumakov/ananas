require 'rails_helper'


RSpec.describe CategoriesController, type: :controller do
  let(:category) { create :category }

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

end
