# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'jbuilder', '~> 2.7'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'rails', '~> 6.1.3'
gem 'webpacker', '6.0.0.beta.6'

gem 'activestorage-validator', '~> 0.1.3'
gem 'dentaku', '~> 3.4'
gem 'devise', '~> 4.7'
gem 'kaminari', '~> 1.2'
gem 'rails-i18n', '~> 6.0'
gem 'slim-rails', '~> 3.2'

gem 'aws-sdk-s3', '~> 1.94', require: false
gem 'require_all', '~> 3.0', require: false

group :development, :test do
  gem 'bullet', '~> 6.1'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  gem 'brakeman', '~> 5.0', require: false
  gem 'guard', '~> 2.17', require: false
  gem 'guard-rspec', '~> 4.7', require: false
  gem 'rails_best_practices', '~> 1.21', require: false
  gem 'reek', '~> 6.0', require: false
  gem 'rspec', '~> 3.10', require: false
  gem 'rspec-rails', '~> 4.0', require: false
  gem 'rubocop', '~> 1.11', require: false
  gem 'rubocop-performance', '~> 1.10', require: false
  gem 'rubocop-rails', '~> 2.9', require: false
  gem 'rubocop-rspec', '~> 2.2', require: false
  gem 'rubycritic', '~> 4.6', require: false
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'pry', '~> 0.14.0'
  gem 'pry-rails', '~> 0.3.9'
  gem 'web-console', '>= 3.3.0'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'html2slim', '~> 0.2.0', require: false
  gem 'lefthook', '~> 0.7.2', require: false
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'crystalball', '~> 0.7.0'
  gem 'faker', '~> 2.17'
  gem 'launchy', '~> 2.5'
  gem 'rails-controller-testing', '~> 1.0'
  gem 'selenium-webdriver', '~> 3.142.7'
  gem 'shoulda-matchers', '~> 4.5'
  gem 'timecop', '~> 0.9.4'
  gem 'webdrivers', '~> 4.6.0'

  gem 'factory_bot_rails', '~> 6.1', require: false
  gem 'simplecov', '~> 0.21.2', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
