# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
Rails.application.routes.draw do
  devise_for :users
  
   root to: "users#index"

   resources :users, only: [:index, :show] do
      resources :posts, only: [:index, :show , :new, :create] do
        resources :comments
        resources :likes
      end
    end


    delete 'users/:user_id/posts/:id' , to: 'posts#destroy'
    get 'users/:user_id/posts/:post_id/comments/:id' , to: 'comments#show'
    delete '/users/:user_id/posts/:post_id/comments/:id' , to: 'comments#destroy'
end 
