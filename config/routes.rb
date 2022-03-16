Rails.application.routes.draw do
  root 'welcome#index'
  get 'tos', to: 'welcome#tos', as: 'tos'
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get "oauth2callback", to:"read_histories#callback"
  delete '/logout', to: 'sessions#destroy'

  resource :retirement

  resources :books, except: %i(new) do
    resource :photos, only: %i(new create)
    resource :read_histories, only: %i(new create)
  end
end
