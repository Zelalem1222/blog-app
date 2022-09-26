class UsersController < ApplicationController
  def index; end

  def show
    @user = 'here is the profile of the user'
  end

  def post
    @posts = "here are the posts of the user with id #{params[:id]}"
  end
end
