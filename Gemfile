# include at least one source and the rails gem
source :gemcutter
gem 'rails', '2.3.8', :require => nil
gem 'postgres'
gem "oauth"
gem "configatron"
gem "json"

# Devise 1.0.2 is not a valid gem plugin for Rails, so use git until 1.0.3
# gem 'devise', :git => 'git://github.com/plataformatec/devise.git', :ref => 'v1.0'

group :plugins do
  # gems that should be loaded in all environments, but depend on Rails to load
#  gem 'newrelic_rpm'
  gem "haml"
end

group :development do
  # bundler requires these gems in development
#  gem 'rails-footnotes'
  gem "ruby-debug"
  gem "nifty-generators"
end

group :test do
  # bundler requires these gems while running tests
  gem 'rspec'
  gem 'rspec-rails'
end
