# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# Configure Jbuilder to use camelCase for JSON keys (for frontend compatibility)
Jbuilder.key_format camelize: :lower
Jbuilder.deep_format_keys true
