require 'rails_helper'

RSpec.describe 'posts show ', type: :feature do
  before(:each) do
    @user = User.create(name: 'user1', photo: 'https://i.imgur.com/1JZrO7A.jpg', bio: 'bio1', posts_counter: 0)
    @user.save!
    visit root_path
    @post = Post.create(title: 'post1', text: 'text1', author: @user, comments_counter: 0, likes_counter: 0)
    @post2 = Post.create(title: 'post2', text: 'text2', author: @user, comments_counter: 0, likes_counter: 0)

    @comment = Comment.create(text: 'comment1', author: @user, post: @post)
    @comment2 = Comment.create(text: 'comment2', author: @user, post: @post)
    visit user_post_path(@user, @post)
  end

  it 'should show the post title' do
    expect(page).to have_content('post1')
  end

  it 'should show the author of the post' do
    expect(page).to have_content('user1')
  end

  it 'should show how many comments the post has' do
    expect(page).to have_content("Comments: #{@post.comments_counter}")
  end

  it 'should show how many likes the post has' do
    expect(page).to have_content("Likes: #{@post.likes_counter}")
  end

  it 'should show the post text' do
    expect(page).to have_content('text1')
  end

  it 'should show the username of each of the comments' do
    expect(page).to have_content('user1')
  end

  it 'should show the comment text each commenter wrote' do
    expect(page).to have_content('comment1')
    expect(page).to have_content('comment2')
  end
end
