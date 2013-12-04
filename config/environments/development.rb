Cinecinetique::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  #AWS.config(:logger => Rails.logger, :http_wire_trace => true, :log_level => :debug)

  config.paperclip_defaults = {
      :storage => Cinecinetique::STORAGE,
      :s3_permissions => :bucket_owner_full_control,
      :s3_credentials => {
        :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
        :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY'],
        :s3_host_name => "s3-ap-southeast-1.amazonaws.com",
        :s3_endpoint => "s3-ap-southeast-1.amazonaws.com"
      }
  }

  ses_credentials = YAML.load_file("/tmp/ses_credentials.yml")
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    :address =>             'email-smtp.us-east-1.amazonaws.com',
    :port =>                587,
    :domain =>              'cinecinetique.com',
    :user_name =>          ses_credentials['SES_USERNAME'],
    :password =>            ses_credentials['SES_PASSWORD'],
    :authentication =>      :login,
    :enable_starttls_auto => true  }

  Firebase.base_uri = "https://ccq-notifications.firebaseio.com/"

  default_url_options[:host] = "localhost:3000"

  ::PAYPAL_URL = ses_credentials['PAYPAL_URL']
  ::IPN_URL = ses_credentials['IPN_URL']
  ::SOLO_PAYPAL_BUTTON = ses_credentials['SOLO_PAYPAL_BUTTON']
  ::INDIES_PAYPAL_BUTTON = ses_credentials['INDIES_PAYPAL_BUTTON']
  ::AGENCIES_PAYPAL_BUTTON = ses_credentials['AGENCIES_PAYPAL_BUTTON']
end
