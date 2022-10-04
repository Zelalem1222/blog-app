require 'rails_helper'

RSpec.describe 'user index ', type: :feature do
  describe 'GET /users/index' do
    before(:each) do
      @user1 = User.create(name: 'user1', photo: 'https://i.imgur.com/1JZrO7A.jpg', bio: 'bio1', posts_counter: 2)
      @user1.save!
      @user2 = User.create(name: 'user2', photo: 'img-2.jpg', bio: 'bio2', posts_counter: 0)
      @user2.save!
    end

    it 'should show all user names' do
      visit users_path
      expect(page).to have_content('user1')
      expect(page).to have_content('user2')
    end

    it 'should show all user photos' do
      visit users_path
      expect(page).to have_css("img[src*='https://i.imgur.com/1JZrO7A.jpg']")
      expect(page).to have_css("img[src*='img-2.jpg']")
    end

    it 'should show the number of posts for each user' do
      visit users_path
      expect(page).to have_content('2')
      expect(page).to have_content('0')
    end

    it 'redirects to the user show page when clicking on the user name' do
      visit users_path
      click_link('user1')
      expect(page).to have_current_path(user_path(@user1))
      expect(page).to have_content('user1')
    end
  end
end
