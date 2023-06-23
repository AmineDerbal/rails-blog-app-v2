Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  get 'home/index'

  # devise_for :users
  devise_for :users, controllers: { registrations: 'registrations' , sessions: 'sessions' }

  # Add the following route for signing out
  delete '/sign_out', to: 'sessions#destroy', as: :custom_destroy_user_session

  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: :custom_login
    post 'login', to: 'devise/sessions#create', as: :custom_user_session
  
    get 'registration', to: 'devise/registrations#new', as: :custom_registration
    post 'registration', to: 'devise/registrations#create', as: :custom_user_registration
  end

  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :create, :new, :destroy] do 
      resources :comments, only: [:create, :new, :destroy]
      post 'like', on: :member
    end  
 end

 namespace :api do
  resources :users, only: [] do
    resources :posts, only: [:index] do
      resources :comments, only: [:index, :create]
    end
  end
end

 



 root 'home#index'

 


  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
