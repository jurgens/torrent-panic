Rails.application.routes.draw do
  require 'sidekiq'
  require 'sidekiq/web'
  require 'sidekiq/cron/web'

  Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
    [user, password] == [ENV['ADMIN_LOGIN'], ENV['ADMIN_PASSWORD']]
  end
  mount Sidekiq::Web, at: "/sidekiq"

  root 'home#index'
  post '/webhooks/telegram', controller: 'webhooks', action: 'telegram'
  get '/releases/:id' => 'releases#show', as: 'release'

  namespace :admin do
    get '/' => 'dashboard#index'
    resources :users, only: [:index]
    resources :broadcasts, only: [:new, :create]
    resources :movies, only: [:index]
    resources :searches, only: [:index]
  end

end
