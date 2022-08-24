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
      resources :databases, controller: 'model_databases', only: %i[index show] do
        post 'sql', to: "queries#index"
        resources :tables, controller: 'model_tables', only: %i[index]
      end
    end

    namespace :admin do
      resources :users, only: %i[index destroy]

      resources :works, only: %i[index create update destroy] do
        patch 'order', to: 'works/orders#update', on: :collection
      end
      resources :chapters, only: %i[index create update destroy] do
        patch 'order', to: 'chapters/orders#update', on: :collection
      end
      resources :practices, only: %i[index create update destroy] do
        patch 'order', to: 'practices/orders#update', on: :collection
      end
    end
  end

  # for development/test login
  get '/login_as/:user_id', to: 'development/user_sessions#login_as' unless Rails.env.production?

  get '*path', to: 'home#index', constraints: lambda { |req| req.path.exclude? 'rails/active_storage' }
end
