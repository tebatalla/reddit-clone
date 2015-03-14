class PostsController < ApplicationController
  before_action :is_author?, only: [:edit, :update]

  def show
    @post = Post.find(params[:id])
    @comments_by_parent_id = @post.comments_by_parent_id
    render :show
  end

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    if @post.save
      flash[:notice] = "Post created!"
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def update
    @post = Post.update(params[:id], post_params)
    if @post.save
      flash[:notice] = "Changes saved"
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def edit
    @post = Post.find(params[:id])
    render :edit
  end

  private
    def post_params
      params.require(:post).permit(:title, :url, :content, sub_ids: [])
    end

    def is_author?
      @post = Post.find(params[:id])
      unless @post.author_id == current_user.id
        flash.now[:errors] = ["Not authorized"]
        redirect_to post_url(@post)
      end
      true
    end
end
