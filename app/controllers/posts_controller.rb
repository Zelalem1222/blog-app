class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      @post.update_user_post_counter(params[:user_id])
      redirect_to user_post_path(@user.id)
      flash[:notice] = 'Your comment was successfully created'
    else
      redirect_to new_user_post_path(@user.id)
      flash[:notice] = 'An error has occurred while creating the post'
    end
  end

  private

  def post_params
    params.require(:post).permit(:tittle, :text, :comments_counter, :likes_counter)
  end
  
end
