# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Woody::Application.initialize!

# Initialize Time format
Time::DATE_FORMATS[:datetime] = '%Y.%m.%d at %k:%M:%S'
Time::DATE_FORMATS[:default] = '%Y.%m.%d %H:%M'
