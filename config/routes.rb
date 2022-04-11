Rails.application.routes.draw do
  root 'welcome#index'
  get 'tos', to: 'welcome#tos', as: 'tos'
  get 'privacy_policy', to: 'welcome#privacy_policy', as: 'privacy_policy'

  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get "oauth2callback", to:"read_histories#callback"
  delete '/logout', to: 'sessions#destroy'

  resource :retirement

  resources :books, except: %i(new) do
    resources :photos, only: %i(new create show update)
    resource :read_histories, only: %i(new create)
  end

  namespace :api, format: 'json' do
    resources :books, only: %i(index)
  end
end
