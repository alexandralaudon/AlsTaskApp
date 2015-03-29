Rails.application.routes.draw do
  root              'static_pages#index'
  get '/terms', to: 'static_pages#terms'
  get '/about', to: 'static_pages#about_page'
  get '/faq',   to: 'static_pages#faq'

  resources :tasks, only: [] do
    resources :comments, only: [:create]
  end

  resources :users
  resources :projects do
    resources :memberships, only: [:index, :create, :update, :destroy]
    resources :tasks
  end

  resources :ptracker, only: [:show]

  get 'sign-up',  to: 'registrations#new'
  post 'sign-up', to: 'registrations#create'

  get 'sign-in',  to: 'authentication#new'
  post 'sign-in', to: 'authentication#create'
  get 'sign-out', to: 'authentication#destroy'

end
