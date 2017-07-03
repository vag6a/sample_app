Rails.application.routes.draw do


  resources :users
    root to: 'static_pages#home', via: [:get, :post]
    match '/signup', to: 'users#new', via: [:get, :post]

    match '/help', to: 'static_pages#help', via: [:get, :post]
    match '/about', to: 'static_pages#about', via: [:get, :post]
    match '/contact', to: 'static_pages#contact', via: [:get, :post]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
