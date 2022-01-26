Rails.application.routes.draw do
  get 'photos/index'
  root 'welcome#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :books, only: %i(index create)
end
