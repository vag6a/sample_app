source "http://artprod.dev.bloomberg.com/artifactory/api/gems/bb-ruby-repos/" # Bloomberg internal gemserver
source "http://artprod.dev.bloomberg.com/artifactory/api/gems/rubygems/" # Bloomberg cache of rubygems.org

gem 'rails'
gem 'bootstrap-sass', '3.3.7'
gem 'bcrypt-ruby', '3.1.5'
gem 'faker', '1.7.3'
gem 'will_paginate', '3.1.6'
gem 'bootstrap-will_paginate', '1.0.0'
gem 'jquery-rails', '4.3.1'

group :development, :test do
  gem 'sqlite3', '1.3.13'
  gem 'rspec-rails', '3.6.0'
  gem 'guard-rspec', '4.7.3'
  gem 'guard-spork'
  gem 'childprocess', '0.3.6'
  gem 'spork', '0.9.2'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier', '1.2.3'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'factory_girl_rails', '4.1.0'
  gem 'cucumber-rails', '1.2.1', :require => false
  gem 'database_cleaner', '0.7.0'
  # gem 'launchy', '2.1.0'
  # gem 'rb-fsevent', '0.9.1', :require => false
  # gem 'growl', '1.0.3'
end

group :production do
  gem 'pg', '0.12.2'
end
