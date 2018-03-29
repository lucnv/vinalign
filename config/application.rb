require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Vinalign
  class Application < Rails::Application
    config.load_defaults 5.1
    config.i18n.load_path += Dir["#{Rails.root.to_s}/config/locales/**/*.{rb,yml}"]
    config.eager_load_paths += Dir[Rails.root.join("app", "services"), Rails.root.join("app", "forms")]
    config.time_zone = "Hanoi"
    config.i18n.enforce_available_locales = true
    I18n.default_locale = :vi
    config.active_job.queue_adapter = :sidekiq
  end
end
