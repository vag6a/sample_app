Rails.application.routes.draw do


  resources :users
  resources :sessions, only: [:new, :create, :destroy]

    root to: 'static_pages#home', via: [:get, :post]

    match '/signup',  to: 'users#new',        via: [:get, :post]
    match '/signin',  to: 'sessions#new',     via: [:get, :post]
    match '/signout', to: 'sessions#destroy', via: :delete

    match '/help', to: 'static_pages#help', via: [:get, :post]
    match '/about', to: 'static_pages#about', via: [:get, :post]
    match '/contact', to: 'static_pages#contact', via: [:get, :post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
