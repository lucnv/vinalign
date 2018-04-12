source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails", "~> 5.1.4"
gem "puma", "~> 3.7"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"

gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
  gem "pry-rails"
  gem "faker"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "devise"
gem "config"
gem "ransack", github: "activerecord-hackery/ransack"
gem "jquery-rails"
gem "pundit"
gem "kaminari"
gem "fog-aws"
gem "carrierwave"
gem "mini_magick"
gem "file_validators"
gem "draper"
gem "bootstrap-kaminari-views"
gem "pg", "~> 0.20"
gem "magnific-popup-rails"
gem "gretel"
gem "capistrano"
gem "capistrano3-puma"
gem "capistrano-rails", require: false
gem "capistrano-bundler", require: false
gem "capistrano-rvm"
gem "capistrano-sidekiq"
gem "redis", "~> 3.0"
gem "ckeditor"
gem "sidekiq"
gem "pg_search"
gem "stringex"
gem "roo"
gem "axlsx", "~> 2.0"
gem "axlsx_rails"
gem "rubyzip"
gem "zip-zip", "~> 0.3"

group :production do
  gem "pg", "~> 0.20"
  gem "faker"
  gem "rails_12factor"
end
