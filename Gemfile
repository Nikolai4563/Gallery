source 'https://rubygems.org'
ruby '2.0.0'
gem 'rails', '3.2.13'
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'ransack'
gem 'paperclip', :git => 'git://github.com/thoughtbot/paperclip.git'

#gem 'gon'
#gem 'rabl-rails'

gem 'resque', :require => 'resque/server'
#gem 'resque-scheduler'


gem 'statemachine', '~> 2.2.0'
gem 'simplecov', :require => false, :group => :test
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'devise'
gem 'haml-rails'
gem 'pg'
gem 'simple_form'
gem 'carrierwave'
gem 'kaminari'
gem 'omniauth-facebook'
gem 'nokogiri'
gem 'activeadmin'
gem 'curb'
gem 'simple_captcha', :git => 'git://github.com/galetahub/simple-captcha.git'
gem 'pusher'
gem 'rmagick'
gem 'annotate', '>=2.5.0'
group :development do
  gem 'hirb'
  gem 'fnordmetric', '>= 1.0.0'
  gem 'bullet'
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :rbx]
  gem 'html2haml'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
end
group :development, :test do
  gem 'factory_girl_rails'
  gem 'puma'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end
group :production do
  gem 'unicorn'
end
group :test do

  gem 'selenium-webdriver'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'email_spec'
end
