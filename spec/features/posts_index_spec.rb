require 'rails_helper'

RSpec.describe 'posts index ', type: :feature do
  before(:each) do
    @user = User.create(name: 'user1', photo: 'https://i.imgur.com/1JZrO7A.jpg', bio: 'bio1', posts_counter: 0)
    @user.save!
    visit root_path
    @post = Post.create(title: 'post1', text: 'text1', author: @user, comments_counter: 0, likes_counter: 0)
    @post2 = Post.create(title: 'post2', text: 'text2', author: @user, comments_counter: 0, likes_counter: 0)

    @comment = Comment.create(text: 'comment1', author: @user, post: @post)
    @comment2 = Comment.create(text: 'comment2', author: @user, post: @post)
  end

  it 'should show the user photo' do
    visit user_posts_path(@user.id)
    expect(page).to have_css("img[src*='https://i.imgur.com/1JZrO7A.jpg']")
  end

  it 'should show the user name' do
    visit user_posts_path(@user.id)
    expect(page).to have_content('user1')
  end

  it 'should show the number of posts for the user' do
    visit(user_posts_path(@user.id))
    @user = User.find(@user.id)
    expect(page).to have_content(@user.posts_counter)
  end

  it 'should show the post title' do
    visit(user_posts_path(@user.id))
    expect(page).to have_content('post1')
    expect(page).to have_content('post2')
  end

  it 'should show the post text' do
    visit(user_posts_path(@user.id))
    expect(page).to have_content('text1')
    expect(page).to have_content('text2')
  end

  it 'should show the first comment for the post' do
    visit(user_posts_path(@user.id))
    expect(page).to have_content('comment1')
  end

  it 'should show how many comments the post has' do
    visit(user_posts_path(@user.id))
    @post = Post.first
    expect(page).to have_content(@post.comments_counter)
  end

  it 'should show how many likes the post has' do
    visit(user_posts_path(@user.id))
    @post = Post.first
    expect(page).to have_content(@post.likes_counter)
  end

  it 'should redirect to the post show page when clicking on the post title' do
    visit(user_posts_path(@user.id))
    click_link 'post1'
    expect(current_path).to eq user_post_path(@user.id, @post.id)
  end
end
