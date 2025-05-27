source "https://rubygems.org"

gem "rails", "~> 8.0.2"
gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "jsbundling-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "cssbundling-rails"
gem "jbuilder"

gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails", "~> 8.0.0"
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-byebug", "~> 3.9"
end

group :development do
  gem "web-console"
end

group :test do
  gem "shoulda-matchers", "~> 6.0"
  gem "simplecov", require: false
end

gem "devise", "~> 4.9"
