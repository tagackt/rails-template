# gem
# ----------------------------------------------------------------
gem 'haml-rails'
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'simple_form'
gem 'carrierwave'
gem 'rmagick'
gem 'gretel'
gem 'kaminari'
gem 'devise'
gem 'devise-i18n'
gem 'cancan'
gem 'thin'
gem 'record_with_operator'



gem_group :development do
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_19, :mri_20, :rbx]
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'letter_opener'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'annotate'
end


gem_group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

gem_group :test do
  gem 'faker'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'    
end

gem_group :staging do
  gem 'rails_12factor'
end

gem_group :staging, :production do
#  gem 'pg'
end


# git
# ----------------------------------------------------------------
git :init
git add: "."
git commit: %Q{ -m 'Initial commit' }
