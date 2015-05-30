source 'https://rubygems.org'
ruby '1.9.3'
gem 'rails', '3.2.13'
gem 'rails_12factor'
gem 'will_paginate', '~> 3.0.6'

gem 'jquery-rails'
gem 'gravatar_image_tag'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
group :test, :development do
  gem "rspec-rails", "~> 2.6"
  gem "faker" , '0.3.1'
  gem 'sqlite3'
  gem 'annotate'
end

group :production do
   gem 'webrat'
   gem 'nokogiri'
   gem 'capybara'
   gem 'pg', '~> 0.17.1'
end


