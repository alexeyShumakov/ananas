require 'rails_helper'

RSpec.describe HistoriesController, type: :controller do

  before(:each) do
    sign_in create(:major_moderator)
  end

  let(:history) { create :history }
  let(:valid_attributes) {
    attributes_for :history
  }

  let(:invalid_attributes) {
    attributes_for :invalid_history
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all histories as @histories" do
      history = create :history, moderated: true
      get :index
      expect(assigns(:histories)).to eq([history])
    end
  end

  describe "GET #show" do
    it "assigns the requested history as @history" do
      get :show, {:id => history.to_param}, valid_session
      expect(assigns(:history)).to eq(history)
    end
  end

  describe "GET #new" do
    it "assigns a new history as @history" do
      get :new, {}, valid_session
      expect(assigns(:history)).to be_a_new(History)
    end
  end

  describe "GET #edit" do
    it "assigns the requested history as @history" do
      history = History.create! valid_attributes
      get :edit, {:id => history.to_param}, valid_session
      expect(assigns(:history)).to eq(history)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new History" do
        expect {
          post :create, {:history => valid_attributes}, valid_session
        }.to change(History, :count).by(1)
      end

      it "assigns a newly created history as @history" do
        post :create, {:history => valid_attributes}, valid_session
        expect(assigns(:history)).to be_a(History)
        expect(assigns(:history)).to be_persisted
      end

      it "redirects to the created history" do
        post :create, {:history => valid_attributes}, valid_session
        expect(response).to redirect_to(History.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved history as @history" do
        post :create, {:history => invalid_attributes}, valid_session
        expect(assigns(:history)).to be_a_new(History)
      end

      it "re-renders the 'new' template" do
        post :create, {:history => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { title: 'new title'}
      }

      it "updates the requested history" do
        history = History.create! valid_attributes
        put :update, {:id => history.to_param, :history => new_attributes}, valid_session
        history.reload
        expect(history.title).to eq('new title')
      end

      it "assigns the requested history as @history" do
        history = History.create! valid_attributes
        put :update, {:id => history.to_param, :history => valid_attributes}, valid_session
        expect(assigns(:history)).to eq(history)
      end

      it "redirects to the private_office" do
        history = History.create! valid_attributes
        put :update, {:id => history.to_param, :history => valid_attributes}, valid_session
        expect(response).to redirect_to(private_office_path)
      end

      it 'moderator can update moderated field' do
        history = create :history
        put :update, {:id => history.to_param, :history => {moderated: true}}
        history.reload
        expect(assigns(:history)).to eq(history)
      end

      it 'user cant update moderated field' do
        sign_in(create :user)
        history = create :history
        put :update, {:id => history.to_param, :history => {moderated: true}}
        expect(assigns(:history).moderated).to eq(false)
      end
    end

    context "with invalid params" do
      it "assigns the history as @history" do
        history = History.create! valid_attributes
        put :update, {:id => history.to_param, :history => invalid_attributes}, valid_session
        expect(assigns(:history)).to eq(history)
      end

      it "re-renders the 'edit' template" do
        history = History.create! valid_attributes
        put :update, {:id => history.to_param, :history => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested history" do
      history = History.create! valid_attributes
      expect {
        delete :destroy, {:id => history.to_param}, valid_session
      }.to change(History, :count).by(-1)
    end

    it 'redirect_to private_office_path' do
      history = History.create! valid_attributes
      delete :destroy, { id: history.to_param }
      expect(response).to redirect_to(private_office_path)
    end
  end

end
