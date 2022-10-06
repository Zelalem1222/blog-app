class Api::V1::PostsController < ApplicationController
  before_action :authorize_request
  before_action :find_user

  def index
    user = User.find(params[:user_id])
    posts = user.posts

    if posts.size.positive?
      render json: posts, status: :ok
    else
      render json: { message: 'No posts found' }, status: :not_found
    end
  end

  def show
    @post = @user.posts.find_by_id!(params[:id])
    render json: @post, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'Post not found' }, status: :not_found
  end

  private

  def find_user
    @user = User.find_by_id!(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'User not found' }, status: :not_found
  end
end
