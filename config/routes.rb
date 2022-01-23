Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/:provider/callback', to: 'sessions#create'
end
