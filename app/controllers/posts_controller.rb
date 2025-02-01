class PostsController < ApplicationController
  before_action :set_post, only: [ :show, :edit, :update, :destroy, :publish ]

  def index
    @posts = policy_scope(Post)
  end

  def show
    authorize @post
  end

  def new
    @post = current_user.posts.new
    authorize @post
  end

  def create
    @post = current_user.posts.new(post_params)
    authorize @post

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new
    end
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully deleted."
  end

  def publish
    authorize @post
    if @post.update(status: :published)
      redirect_to @post, notice: "Post was successfully published."
    else
      redirect_to @post, alert: "Failed to publish post."
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    permitted_params = [ :title, :content ]
    permitted_params << :status if policy(@post || Post).publish?
    params.require(:post).permit(permitted_params)
  end
end
