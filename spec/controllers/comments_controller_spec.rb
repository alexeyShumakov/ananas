require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:user) { create :major_moderator }
  let(:post_model ) { create(:post, user: user) }
  let(:valid_attrs) { { body: 'text', post_id: post_model.id } }
  let(:invalid_attrs) { { body: nil, post_id: post_model.id } }
  before(:each) do
    sign_in user
  end

  describe "GET #index" do
    before(:each) do
      sign_out user
    end
    it 'assigns comments' do
      comment = create :comment, post: post_model
      get :index, post_id: post_model.id
      expect(assigns(:comments)).to eq([comment])
    end
    it 'ok status' do
      get :index, post_id: post_model.id
      expect(response).to have_http_status(:ok)
    end
  end
  describe "POST #create" do
    context "with valid params" do
      it "creates a new Comment" do
        expect { post :create, comment: valid_attrs }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post :create, {comment: valid_attrs}
        expect(assigns(:comment)).to be_a(Comment)
        expect(assigns(:comment)).to be_persisted
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        post :create, {comment: invalid_attrs}
        expect(assigns(:comment)).to be_a_new(Comment)
      end
    end

    context 'user must sign in for creating comment' do
      before(:each) do
        sign_out user
      end

      it 'cant create commnet' do
        expect { post :create, comment: valid_attrs }.to change(Comment, :count).by(0)
      end

      it 'redirect_to new_user_session_path' do
        post :create, comment: valid_attrs
        expect(response).to redirect_to(new_user_session_path) 
      end
    end
  end

  describe "PUT #update" do

    let(:comment) { create :comment, user: user }
    let(:new_attrs) { {body: 'new comment text'} }

    context "with valid params" do
      it "updates the requested comment" do
        put :update, {id: comment.id, body: new_attrs[:body]}
        comment.reload
        expect(comment.body).to eq(new_attrs[:body])
      end

      it "assigns the requested comment as @comment" do
        put :update, {id: comment.id, comment: valid_attrs}
        expect(assigns(:comment)).to eq(comment)
      end
    end

    context "with invalid params" do
      it "assigns the comment as @comment" do
        put :update, {id: comment.id, comment: invalid_attrs}
        expect(assigns(:comment)).to eq(comment)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:comment) { create :comment, user: user }

    it "destroys the requested comment" do
      expect {
        delete :destroy, {id: comment.id}
      }.to change(Comment, :count).by(-1)
    end
  end

end
