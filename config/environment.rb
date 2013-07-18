# Load the Rails application.
require File.expand_path('../application', __FILE__)
Writing::Application.configure do
  config.assets.paths << "#{Rails.root}/app/assets/fonts"
end
# Initialize the Rails application.
Writing::Application.initialize!
