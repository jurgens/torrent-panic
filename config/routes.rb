Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #

  root 'home#index'
  post '/webhooks/telegram', controller: 'webhooks', action: 'telegram'
  get '/releases/:id' => 'releases#show', as: 'release'

  namespace :admin do
    get '/' => 'dashboard#index'
    resources :users, only: [:index]
    resources :broadcasts, only: [:new, :create]
  end
end
