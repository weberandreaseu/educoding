require_relative 'boot'
require 'rails/all'
require 'capybara'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Educoding
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]
    # config.i18n.default_locale = :de

    # Capybara.default_driver = :selenium
    Capybara.javascript_driver = :webkit
    Capybara.default_max_wait_time = 10

    # customize generators
    config.generators do |g|
      g.test_framework  false
    end
  end
end
