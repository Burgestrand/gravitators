source "https://rubygems.org"

gem "rails", "3.2.11"

group :assets do
  gem "serenade", require: "serenade/rails"
  gem "bourbon"
  gem "normalize-rails"
  gem "sass-rails",   "~> 3.2.3"
  gem "coffee-rails", "~> 3.2.1"
  gem "uglifier", ">= 1.0.3"
end

group :development do
  # LiveReload
  gem "guard-livereload" # websocket server
  gem "rb-fsevent"       # faster filesystem events for guard
  gem "rack-livereload"  # automatically include livereload.js
end
