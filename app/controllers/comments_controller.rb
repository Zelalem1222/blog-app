class CommentsController < ApplicationController

  load_and_authorize_resource 

  def create
    @post = Post.find(params[:post_id])
    @user = current_user
    @comment = Comment.new(comment_params)
    @comment.author = @user
    @comment.post = @post
    if @comment.save
      redirect_to user_post_path(@user, @post), notice: 'Comment was successfully created.'
    else
      render 'posts/show', alert: 'Comment was not created.'
    end
  end

  def new
    @comment = Comment.new
  end

  def destroy
    @comment = Comment.find(params[:id])
    @author = @comment.author
    @post = Post.find(@comment.post_id)
    @post.decrement!(:comments_counter)
    @comment.destroy
    redirect_to user_posts_url(id: @author.id), notice: 'Comment was successfully deleted.'
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
