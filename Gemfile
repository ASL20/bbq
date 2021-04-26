source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails', '~> 6.0.3', '>= 6.0.3.4'

# девайз и локализация
gem 'devise'
gem 'devise-i18n'
gem 'rails-i18n'
gem 'pundit'

# гемы для работы с загрузкой изображений
gem 'carrierwave'
gem 'rmagick'
gem 'fog-aws'

# почта и env
gem 'mailjet'
gem 'dotenv-rails'

gem 'webpacker', '~> 4.0'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3', '~> 1.4'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
end

group :development do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-passenger'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
end
