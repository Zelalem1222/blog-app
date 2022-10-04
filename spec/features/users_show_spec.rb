require 'rails_helper'

RSpec.describe 'user show ', type: :feature do
  before(:each) do
    @user = User.create(name: 'user1', photo: 'https://i.imgur.com/1JZrO7A.jpg', bio: 'bio1', posts_counter: 2)
    @user.save!
    @post = Post.create(title: 'post1', text: 'text1', comments_counter: 0, likes_counter: 0 , author: @user)
    @post2 = Post.create(title: 'post2', text: 'text2', comments_counter: 0, likes_counter: 0 , author: @user)
    @post3 = Post.create(title: 'post3', text: 'text3', comments_counter: 0, likes_counter: 0 , author: @user)
    visit user_path(id: @user.id)
  end

  it 'should show the user photo' do
    expect(page).to have_css("img[src*='https://i.imgur.com/1JZrO7A.jpg']")
  end

  it 'should show the user name' do
    expect(page).to have_content('user1')
  end

  it 'should show the number of posts for the user' do
    expect(page).to have_content('2')
  end

  it 'should show the user bio' do
    expect(page).to have_content('bio1')
  end

  it 'should show the users 3 most recent posts' do
    expect(page).to have_content('post')
    expect(page).to have_content('post2')
    expect(page).to have_content('post3')
  end

  it 'can see a button that lets view all of a users posts' do
    expect(page).to have_link('See all posts')
  end

  it 'should redirect to the post show page when click on a post' do
    click_link('post1')
    expect(page).to have_content('text1')
  end

  it 'clicking see all posts it redirects to the users posts index page' do
    click_link 'See all posts'
    expect(page).to have_content('Blog App')
    expect(page).to have_content('Number of posts: 5')
  end
end
