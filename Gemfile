source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.6.3'

# core
gem 'rails', '~> 5.2.0'
gem 'bootsnap'

# storage
gem 'pg', '~> 1.2.3'

# web server
gem 'puma', '~> 4.3.3'

# frontend
gem 'mini_racer'
gem 'sass-rails', '~> 6.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 5.0.0'
gem 'bootstrap', '~> 4.0.0'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails', '~> 4.3.3'

# xml
gem 'nokogiri'
gem 'mechanize'

# external api
gem 'telegram-bot-ruby', '~> 0.12.0'
gem 'themoviedb', github: 'ahmetabdi/themoviedb'

# config
gem 'dotenv-rails', '~> 2.7.5'

# background
gem 'sidekiq', '~> 5.2.7'
gem 'sidekiq-cron', '~> 1.2.0'
gem 'sidekiq-failures'

# helpers
gem 'rollbar', '~> 2.24.0'

group :development, :test do
  gem 'byebug'
  gem 'pry-byebug'
  gem 'rspec-rails'
end

group :test do
  gem 'factory_bot_rails', '~> 5.1.1'
  gem 'capybara'
  gem 'shoulda-matchers', '~> 3.1.2'
  gem 'webmock'
  gem 'vcr'
end

group :development do
  gem 'sqlite3', '~> 1.4.2'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard'
  gem 'guard-rspec'
  gem 'better_errors'
  gem 'spring-commands-rspec'

  gem 'capistrano', '~> 3.0',     require: false
  gem 'capistrano-rails',         require: false
  gem 'capistrano-rvm',           require: false
  gem 'capistrano-passenger',     require: false
  gem 'capistrano-sidekiq',       require: false
end
