class PostsController < ApplicationController
   
  def index
    @user = User.find(params[:user_id])
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to user_post_path(current_user, @post)
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

# Path: app\views\posts\index.html.erb
# Compare this snippet from app\views\comments\index.html.erb:
# <h1>Comments</h1>
# 
# <ul>
#   <% @comments.each do |comment| %>
#     <li>
#       <%= comment.text %>
#     </li>
#   <% end %>
# </ul>
# 
# <%= link_to "New Comment", new_comment_path %>
# 
# Compare this snippet from app\views\likes\index.html.erb:
# <h1>Likes</h1>
# 
# <ul>
#   <% @likes.each do |like| %>
#     <li>
#       <%= like.post.title %>
#     </li>
#   <% end %>
# </ul>
# 
# <%= link_to "New Like", new_like_path %>
# 
# Compare this snippet from app\views\users\index.html.erb:
# <h1>Users</h1>
# 
# <ul>
#   <% @users.each do |user| %>
#     <li>
#       <%= user.name %>
#     </li>
#   <% end %>
# </ul>
# 
# <%= link_to "New User", new_user_path %>
# 
# class PostsController < ApplicationController
  # def index
    # @posts = Post.all
  # end

# end
