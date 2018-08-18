# frozen_string_literal: true

Devise.setup do |config|
  require 'devise/orm/active_record'

  config.omniauth :facebook,
                  ENV['FACEBOOK_APP_ID'],
                  ENV['FACEBOOK_APP_SECRET']

  config.omniauth :google_oauth2,
                  ENV['GOOGLE_CLIENT_ID'],
                  ENV['GOOGLE_CLIENT_SECRET']

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.password_length = 6..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.sign_out_via = :delete
end
