# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ActionController::Base.cache_store = :file_store, "#{Rails.root}/public/cache"
#Gallery::Application.initialize!
