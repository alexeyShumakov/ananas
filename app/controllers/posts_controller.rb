class PostsController < ApplicationController
  include TextHelper
  before_action :set_post, only: [:show, :edit, :destroy, :update]
  before_action :set_categories, only: [:edit, :new, :create, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  after_action :verify_authorized, only: [:new, :create, :edit, :update, :destroy]

  def user_posts
    @user = User.find(params[:id])
    @user_posts = @user.posts
  end

  def best_authors
    @posts = Post.best_authors.as_json.each {|x| x['url'] = user_posts_path(x['id'])}
    render json: @posts
  end

  def search
    @posts = Post.search_by_title(params[:keyword]).limit(10)
    render json: @posts
  end

  def show
    impr_count = @post.impressionist_count(filter: :ip_address, start_date: 15.seconds.ago)
    if impr_count < 1
      impressionist @post
      @post.impressions_count = @post.impressions_count + 1
      @post.save
    end
    @json_post = PostSerializer.new(@post, {scope: current_user}).as_json
  end

  def new
    authorize Post
    @post = Post.new
  end

  def edit
    authorize @post
  end

  def create
    authorize Post
    @post = Post.new post_params
    @post.user = current_user
    @post.slug = post_params[:title].parameterize
    if @post.valid?
      set_md_body
      redirect_to @post, notice: 'Good!'
    else
      render :edit
    end
  end

  def update
    authorize @post
    @post.slug = post_params[:title].parameterize
    if @post.update post_params
      set_md_body
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to root_path, notice: 'Post was deleted.'
  end

  def md_preview
    @text = { text: to_markdown(params[:text]) }
    render json: @text.to_json, status: :ok
  end

  private

  def set_md_body
      @post.md_body = to_markdown @post.body
      @post.save
  end

  def set_post
    @post = Post.friendly.includes(:user, comments: [:user]).find(params[:id])
  end

  def post_params
    params.require(:post).permit(:category_id, :title, :sinopsis, :avatar, :body)
  end

  def set_categories
    @categories = Category.all
  end
end
