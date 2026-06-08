source "https://rubygems.org"

# Minimal Rails
gem "rails", "~> 8.1.3"
gem "activesupport"
gem "sqlite3", ">= 2.1"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Minimal asset handling
gem "propshaft"
gem "importmap-rails"
gem "turbo-rails"

# neo4j
gem "activegraph", "11.5.0.beta.3"
gem "neo4j-ruby-driver"
gem "benchmark"
gem 'connection_pool', '~> 2.4'

group :development, :test do
  gem "dotenv", groups: [:development, :test]
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
end
