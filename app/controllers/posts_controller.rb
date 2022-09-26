class PostsController < ApplicationController
  def index
    @posts = "here are the posts of the user with id #{params[:user_id]}"
  end

  def show
    @post = "here is the post with id #{params[:id]}"
  end
end
