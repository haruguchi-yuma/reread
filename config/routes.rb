Rails.application.routes.draw do
  root 'welcome#index'
  get 'tos', to: 'welcome#tos', as: 'tos'
  get 'privacy_policy', to: 'welcome#privacy_policy', as: 'privacy_policy'

  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  delete '/logout', to: 'sessions#destroy'

  resource :retirement

  resources :books, except: %i(new) do
    resources :photos, only: %i(new create show update)
    resource :read_histories, only: %i(new create)
  end
end
