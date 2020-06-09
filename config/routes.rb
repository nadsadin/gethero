Rails.application.routes.draw do
  root 'home#index'
  mount Payanyway::Engine => '/payanyway'
  get '/service-worker.js' => "service_worker#service_worker"
  get '/manifest.json' => "service_worker#manifest"
  devise_for :users,  :controllers => {:registrations => "registrations"}
  namespace :admin do
    authenticate :user do
      root 'dashboard#index'
      get 'dashboard' => 'dashboard#index'
      resources :users
      resources :categories
      resources :activity_types
      resources :withdrawals, only: [:index, :show, :new, :create] do
        get 'cc_confirmation', on: :collection
      end
      resources :pages
      resources :posts
      resources :personal_pages
      resources :activities
    end
  end
  resources :pages, only: [:show]
  resources :blog, only: [:show, :index], controller: 'posts'
  get 'users/sign_up/success' => 'custom_registrations#successful_registration'
  resources :personal_pages, only: [:show], path: '' do
    resources :donates, only: [:new, :create]
    resources :activities, only: [:show], path: ''
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
