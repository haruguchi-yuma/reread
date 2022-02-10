Rails.application.routes.draw do
  get 'read_histories/new'
  root 'welcome#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resource :retirement

  resources :books, except: %i(new) do
    resource :photos, only: %i(new create)
  end
end
