@ruby_version = ask("ruby version?(Ex. 2.1.5)")
@app_name = ask("application name?")#もう一回うたないといけないのがイケてない
# @database_user = ask("database user?")

# clean file
# ----------------------------------------------------------------
run 'rm README.rdoc'
run 'touch README.md'
run 'touch .env'

run 'mv app/assets/stylesheets/application.css app/assets/stylesheets/application.sass'
append_file 'app/assets/stylesheets/application.sass', <<-END
/*
 *= require font-awesome
 */
@import 'bootstrap-sprockets'
@import 'bootstrap'
END

append_file 'app/assets/javascripts/application.js', <<-END
//= require bootstrap-sprockets
END


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

run 'html2haml -e app/views/layouts/application.html.erb app/views/layouts/application.html.haml'
run 'rm app/views/layouts/application.html.erb'

run "createdb #{@app_name}_development"
run "createdb #{@app_name}_test"


#database.yml
# gsub_file 'config/database.yml', /#username: /, ''

# Generators
# ----------------------------------------------------------------
generate 'simple_form:install --bootstrap'
generate 'rspec:install'

#devise
generate 'devise:install'
run 'rails generate devise user'
run 'rails generate devise:views'
#erbで生成されるため、haml化
run 'for file in app/views/devise/**/*.erb; do html2haml -e $file ${file%erb}haml && rm $file; done'

run 'guard init rspec'

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
    # generateのcssファイルはsassを生成
    config.sass.preferred_syntax = :sass
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

#
rake 'db:migrate'