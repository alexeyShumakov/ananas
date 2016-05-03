require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { create :user }
  let(:comment) { create :comment}
  before(:each) do
    sign_in user
  end
  describe "#post create" do

    it 'assigns like' do
      post :create, like: {comment_id: comment.id}
      expect(assigns(:like)).to be_a(Like)
    end

    it 'assigns comment' do
      post :create, like: {comment_id: comment.id}
      expect(assigns(:comment)).to eq(comment)
    end

    it 'create like new like' do
        expect { post :create, like: {comment_id: comment.id}}.to change(Like, :count).by(1)
    end

    it 'destroy like if it exist' do
      create :like, comment_id: comment.id, user_id: user.id
      expect { post :create, like: {comment_id: comment.id}}.to change(Like, :count).by(-1)
    end

  end
end
