Rails.application.routes.draw do
  root 'home#index'
  namespace :api do
    resources :works, param: :slug, only: %i[index show]
    resources :practices, only: %i[show]

    namespace :samples do
      resources :databases, controller: 'model_databases', only: %i[index show] do
        post 'sql', to: "queries#index"
        resources :tables, controller: 'model_tables', only: %i[index]
      end
    end
  end
  get '*path', to: 'home#index', constraints: lambda { |req| req.path.exclude? 'rails/active_storage' }
end
