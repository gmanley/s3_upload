source :rubygems

gem 'rails', '~> 3.2.1'

gem 'haml-rails'
gem 'coffee-filter'
gem 'coffeebeans'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier',     '>= 1.0.3'
end

gem 'jquery-rails'

gem 'mongoid', '~> 2.4'
gem 'bson_ext'
gem 'mongoid_slug'
gem 'mongoid-tree', :require => 'mongoid/tree'
gem 'kaminari', git: 'git://github.com/amatsuda/kaminari.git'

gem 'devise'
gem 'cancan'

gem 'responders'

gem 'carrierwave', git: 'git://github.com/jnicklas/carrierwave.git'
gem 'carrierwave-mongoid', require: 'carrierwave/mongoid'
gem 'mini_magick', git: 'git://github.com/gmanley/mini_magick.git', branch: 'graphicsmagick-fix'
gem 'fog'

group :development do
  gem 'itslog'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'growl' # install growlnotify (http://growl.info/extras.php#growlnotify)
  gem 'pry'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'mongoid-rspec', git: 'git://github.com/evansagge/mongoid-rspec.git'
  # gem 'capybara-webkit', git: 'git://github.com/thoughtbot/capybara-webkit.git' # brew install qt
end

group :development, :test do
  gem 'rspec-rails', '~> 2.8'
  gem 'fabrication'
  gem 'ffaker'
  gem 'spork'
  gem 'launchy'
end

# Unccomment this and run bundle if you need to run the importer.
# After your done using the importer make sure to comment this block out
# again and run `bundle` or you may run into issues.
# group :importer do
#   gem 'dm-core'
#   gem 'dm-mysql-adapter'
#   gem 'progressbar'
#   gem 'parallel'
# end
