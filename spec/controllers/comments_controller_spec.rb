require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  let(:user) { create :major_moderator }
  let(:post_model ) { create(:post, user: user) }
  let(:valid_attrs) { { body: 'text', post_id: post_model.id } }
  let(:invalid_attrs) { { body: nil, post_id: post_model.id } }
  before(:each) do
    sign_in user
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
  end

  describe "PUT #update" do

    let(:comment) { create :comment, user: user }
    let(:new_attrs) { {body: 'new comment text'} }

    context "with valid params" do
      it "updates the requested comment" do
        put :update, {id: comment.id, comment: new_attrs}
        comment.reload
        expect(comment.body).to eq(new_attrs[:body])
      end

      it "assigns the requested comment as @comment" do
        put :update, {id: comment.id, comment: valid_attrs}
        expect(assigns(:comment)).to eq(comment)
      end

      it "redirects to the comment" do
        put :update, {id: comment.id, comment: valid_attrs}
        expect(response).to redirect_to(comment)
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

    it "redirects to the comments list" do
      delete :destroy, {id: comment.id}
      expect(response).to redirect_to(post_path(comment.post.id))
    end
  end

end
