Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #

  root 'home#index'
  post '/webhooks/telegram', controller: 'webhooks', action: 'telegram'

  namespace :admin do
    get '/' => 'dashboard#index'
  end
end
