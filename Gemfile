source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'sqlite3'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'nokogiri'
gem 'pg', '~> 0.1'
gem 'mechanize'
gem 'therubyracer'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'

gem 'telegram-bot-ruby'
gem 'dotenv-rails'
gem 'sidekiq'
gem 'themoviedb'
gem 'bootstrap', '~> 4.0.0'
gem 'jquery-rails'
gem 'rollbar'

# gem 'redis', '~> 3.0'
# gem 'bcrypt', '~> 3.1.7'

group :development, :test do
  gem 'byebug'
  gem 'pry-byebug'
  gem 'rspec-rails'
end

group :test do
  gem 'factory_bot_rails', '~> 4.0'
  gem 'capybara'
  gem 'shoulda-matchers'
end

group :development do
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

