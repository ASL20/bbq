source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.0'

gem 'rails', '~> 6.0.3', '>= 6.0.3.4'

gem 'devise'
gem 'devise-i18n'
gem 'rails-i18n'

gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'

gem 'carrierwave'
gem 'rmagick'
gem 'fog-aws'

gem 'webpacker', '~> 4.0'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3', '~> 1.4'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end
