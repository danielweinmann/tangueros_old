source 'http://rubygems.org'

# For heroku
ruby '1.9.3'

gem 'rails', '3.2.12'
gem "inherited_resources"

# Database
gem 'pg', ">= 0.16.0"
gem "foreigner"

# Views
gem "slim", "~> 1.0.2"
gem "slim-rails"

# Application-specific
gem "httparty"
gem 'simple_form'

group :production do

  # Gem used to handle image uploading
  gem 'fog', '>= 1.3.1'

  # Workers, forks and all that jazz
  gem 'unicorn'

  # Enabling Gzip on Heroku
  # If you don't use Heroku, please comment the line below.
  gem 'heroku-deflater', '>= 0.4.1'


  # Monitoring with the new new relic
  gem 'newrelic_rpm'

  # Using dalli and memcachier have not presented significative performance gains
  # Probably this is due to our pattern of cache usage
  # + the lack of concurrent procs in our deploy
  #gem 'memcachier'
  #gem 'dalli'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "compass-rails"
  gem "compass-960-plugin"
  gem 'sass-rails',   '~> 3.2.1'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development do
  gem "mailcatcher"
end

group :test do
  # Pretty printed test output
  gem "rspec", "~> 2.8.0"
  gem "machinist", ">= 2.0.0.beta2"
  gem "database_cleaner", "~> 0.6.7"
  gem "ffaker", "~> 1.8.1"
  gem "shoulda-matchers", "~> 1.0.0.beta3"
end

group :development, :test do
  gem "rspec-rails", "~> 2.8.0"
  gem "silent-postgres"
  gem "jasmine"
end
