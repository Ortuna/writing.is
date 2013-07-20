ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

def fake_hash
  {
    provider: 'github',
    uid:      'uid',
    credentials: {
     token: '1234'
    },
    info: {
      name: 'test_user',
      image: 'some_string',
      role:  'author'
    }
  }.with_indifferent_access
end
