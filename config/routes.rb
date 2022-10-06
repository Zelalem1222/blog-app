# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  
   root to: "users#index"

   resources :users, only: [:index, :show] do
      resources :posts, only: [:index, :show , :new, :create] do
        resources :comments
        resources :likes
      end
    end

    resources :users, param: :_user_id
    post 'api/v1/auth/login', to: 'authentication#login'

    namespace :api do
      namespace :v1 do
        resources :users, only: [:index] do
          resources :posts, only: [:index , :show] do 
            resources :comments, only: [:index , :show , :create]
          end
        end
    end
   end


    delete 'users/:user_id/posts/:id' , to: 'posts#destroy'
    get 'users/:user_id/posts/:post_id/comments/:id' , to: 'comments#show'
    delete '/users/:user_id/posts/:post_id/comments/:id' , to: 'comments#destroy'
end 
