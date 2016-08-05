require 'raddocs'
require 'rack/test'
require 'capybara/rspec'

module Raddocs
  class App
    set :environment, :test
  end
end

Capybara.configure do |config|
  config.match = :prefer_exact
  config.ignore_hidden_elements = false
end

RSpec.configure do |config|
  config.include Capybara::DSL

  config.before do
    Capybara.app = Raddocs::App
  end
end

Raddocs.configure do |config|
  config.api_name = "Raddocs Test"
  config.docs_dir = "spec/fixtures"
  config.guides_dir = "spec/fixtures"
  config.external_css = "http://example.com/my-external.css"
  config.include_bootstrap = false
end
