# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

gem "bootsnap", ">= 1.4.2", require: false
gem "jbuilder", "~> 2.7"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 4.1"
gem "rails", "~> 6.0.3", ">= 6.0.3.5"
gem "sass-rails", ">= 6"
gem "turbolinks", "~> 5"
gem "webpacker", "~> 4.0"

gem "pry", "~> 0.14.0"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]

  gem "factory_bot_rails", "~> 6.1"
  gem "rspec-rails", "~> 4.0"

  gem "brakeman", "~> 5.0"
  gem "bullet", "~> 6.1"

  gem "reek", "~> 6.0"
  gem "rubocop", "~> 1.11"
  gem "rubocop-performance", "~> 1.10"
  gem "rubocop-rails", "~> 2.9"
  gem "rubocop-rspec", "~> 2.2"
end

group :development do
  gem "listen", "~> 3.2"
  gem "web-console", ">= 3.3.0"

  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"

  gem "launchy", "~> 2.5"
  gem "rails-controller-testing", "~> 1.0"
  gem "shoulda-matchers", "~> 4.5"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

gem "devise", "~> 4.7"

gem "slim-rails", "~> 3.2"

gem "dentaku", "~> 3.4"
