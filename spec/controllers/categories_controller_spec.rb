require 'rails_helper'


RSpec.describe CategoriesController, type: :controller do
  let(:category) { create :category }

  describe "GET #show" do
    it 'assigns @category' do
      get :show, id: category.id
      expect(assigns :category).to eq(category)
    end
  end

end
