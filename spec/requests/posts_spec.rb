require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/users/1/posts'
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/users/1/posts'
      expect(response).to render_template('index')
    end

    it 'show correct content' do
      get '/users/1/posts'
      expect(response.body).to include('here are the posts of the user with id 1')
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/users/1/posts/1'
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get '/users/1/posts/1'
      expect(response).to render_template('show')
    end

    it 'show correct content' do
      get '/users/1/posts/1'
      expect(response.body).to include('here is the post with id 1')
    end
  end
end
