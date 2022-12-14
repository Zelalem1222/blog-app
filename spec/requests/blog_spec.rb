require 'swagger_helper'

describe 'Blogs API' do
  path '/blogs' do
    post 'Creates a blog' do
      tags 'Blogs'
      consumes 'application/json'
      parameter name: :blog, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          text: { type: :string }
        },
        required: %w[title text]
      }

      response '201', 'blog created' do
        let(:blog) { { title: 'foo', text: 'bar' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:blog) { { title: 'foo' } }
        run_test!
      end
    end
  end

  path '/blogs/{id}' do
    get 'Retrieves a blog' do
      tags 'Blogs', 'Another Tag'
      produces 'application/json', 'application/xml'
      parameter name: :id, in: :path, type: :string

      response '200', 'blog found' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 title: { type: :string },
                 text: { type: :string }
               },
               required: %w[id title text]

        let(:id) { Blog.create(title: 'foo', text: 'bar').id }
        run_test!
      end

      response '404', 'blog not found' do
        let(:id) { 'invalid' }
        run_test!
      end

      response '406', 'unsupported accept header' do
        let(:Accept) { 'application/foo' }
        run_test!
      end
    end
  end
end
