@ruby_version = ask("ruby version?(Ex. 2.1.5)")
# @database_user = ask("database user?")

# clean file
# ----------------------------------------------------------------
run 'rm README.rdoc'
run 'touch README.md'

append_file '.gitignore', <<-END
#rubymine
.idea/*
END

# gem
# ----------------------------------------------------------------
remove_file 'Gemfile'
create_file 'Gemfile'
add_source 'https://rubygems.org'
append_file 'Gemfile', <<-END
ruby '#{@ruby_version}'#herokuのため
END
gem 'rails'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'haml-rails'
gem 'bootstrap-sass'
gem 'font-awesome-rails'
gem 'simple_form'
gem 'carrierwave'
gem 'mini_magick'
gem 'fog'
gem 'gretel'
gem 'kaminari'
gem 'devise'
gem 'devise-i18n'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'cancan'
gem 'squeel'
# gem 'record_with_operator'
# gem 'enum_help'
gem 'pg'
gem 'dotenv-rails'
gem 'sprockets'

gem_group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'letter_opener'
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'annotate'
  gem 'hirb'
  gem 'hirb-unicode'
  gem 'pry-rails'
  gem 'html2haml'
end

gem_group :development, :test do
  gem 'thin'
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

gem_group :staging, :production do
  gem 'unicorn'
  gem 'rails_12factor'#herokuでの実行のため
end

# run "bundle install" #自動で実施されるぽい

#database.yml
# gsub_file 'config/database.yml', /#username: /, ''

# Generators
# ----------------------------------------------------------------
generate 'simple_form:install --bootstrap'

#devise
generate 'devise:install'
run 'rails generate devise user'

# set config/application.rb
application  do
  %q{
    # Set timezone
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    # 日本語化
    I18n.enforce_available_locales = true
    # config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ja
  }
end

# set Japanese locale
# brew install wget が必要(wgetが無ければ)
run 'wget https://raw.github.com/svenfuchs/rails-i18n/master/rails/locale/ja.yml -P config/locales/'

# git
# ----------------------------------------------------------------
git :init
git add: "."
git commit: %Q{ -m 'Initial commit' }
