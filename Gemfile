source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'spree', github: 'spree/spree', branch: 'master'
gem 'privacygate', github: 'privacyshore/privacygate-ruby'
# Provides basic authentication functionality for testing parts of your engine
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: 'master'
gem 'rails-controller-testing'

gem 'rubocop', require: false
gem 'rubocop-rspec', require: false
gemspec
