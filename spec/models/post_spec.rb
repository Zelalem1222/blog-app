require 'rails_helper'

RSpec.describe Post, type: :model do

 before(:all) do
    @user = User.new(name: 'Lilly', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Poland.')
    @post = Post.new(title: 'My first post', text: 'This is my first post.', author: @user , comments_counter: 4, likes_counter: 6) 
  end
 
  it 'title should be present' do
    @post.title = nil
    expect(@post).to_not be_valid
  end
  
  it 'title length should not be greater than 250' do
    @post.title = 'a' * 251
    expect(@post).to_not be_valid
  end

  it 'comments_counter should be integer' do
    @post.comments_counter = 'one'
    expect(@post).to_not be_valid
  end

  it 'comments_counter should be greater than or equal to 0' do
    @post.comments_counter = -1
    expect(@post).to_not be_valid
  end

  it 'likes_counter should be integer' do
    @post.likes_counter = 'one'
    expect(@post).to_not be_valid
  end

    it 'likes_counter should be greater than or equal to 0' do
    @post.likes_counter = -1
    expect(@post).to_not be_valid
  end
 
  it 'likes_counter should be integer' do
    expect(@post.likes_counter).to be_an(Integer)
  end

end