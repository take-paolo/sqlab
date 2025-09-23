Rails.application.routes.draw do
  root 'home#index'
  namespace :api do
    resources :works, param: :slug, only: %i[index show]
    resources :practices, only: %i[show]
    resources :bookmarks, only: %i[index create destroy]
    resource  :auth_user, only: %i[show update destroy]

    post 'oauth/callback', to: 'oauths#callback'
    get 'oauth/callback', to: 'oauths#callback'
    get 'oauth/:provider', to: 'oauths#oauth', as: :auth_at_provider
    delete 'logout', to: 'user_sessions#destroy'

    namespace :samples do
      post 'query', to: "queries#execute"
    end

    namespace :admin do
      resources :users, only: %i[index destroy]

      resources :works, only: %i[index create update destroy] do
        patch 'order', to: 'works#update_order', on: :collection
      end
      resources :chapters, only: %i[index create update destroy] do
        patch 'order', to: 'chapters#update_order', on: :collection
      end
      resources :practices, only: %i[index create update destroy] do
        patch 'order', to: 'practices#update_order', on: :collection
      end
      resources :sample_databases, only: %i[index]
    end
  end

  # for development/test login
  get '/login_as/:user_id', to: 'development/user_sessions#login_as' unless Rails.env.production?

  get '*path', to: 'home#index', constraints: lambda { |req| req.path.exclude? 'rails/active_storage' }
end
