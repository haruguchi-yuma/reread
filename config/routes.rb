Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :books, only: %i(index create) do
    resources :photos, only: %i(index create)
  end
end
