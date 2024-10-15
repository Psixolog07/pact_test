# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 2.7.6'

gem 'active_interaction', '~> 5.3'
gem 'bootsnap'
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
gem 'puma', '~> 3.11'
gem 'rails', '~> 6.0.0'

group :development do
  gem 'listen'
end

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails', '~> 5.0.0'
end

gem 'rubocop', require: false
