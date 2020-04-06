source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.6.3'

gem 'rails', '~> 5.2.0'
gem 'bootsnap'
gem 'sqlite3', '~> 1.3.13'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'nokogiri'
gem 'pg', '~> 0.21.0'
gem 'mechanize'
gem 'mini_racer'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'telegram-bot-ruby', '~> 0.8.6.1'
gem 'dotenv-rails', '~> 2.7.5'
gem 'sidekiq', '~> 5.2.7'
gem 'sidekiq-cron', '~> 1.1.0'
gem 'sidekiq-failures'
gem 'themoviedb', github: 'kodolabs/themoviedb'
gem 'bootstrap', '~> 4.0.0'
gem 'jquery-rails', '~> 4.3.3'
gem 'rollbar', '~> 2.16.0'

# gem 'redis', '~> 3.0'
# gem 'bcrypt', '~> 3.1.7'

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

