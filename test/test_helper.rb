ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha/setup'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def login_as(user)
  	session[:user_id] = users(user).id
    session[:email] = users(user).email
  end

  def logout
  	session.delete :user_id
  end

  def setup
  	login_as :one if defined? session
    session[:current_project] = projects(:one).id
    # AWS.config(
    #     :access_key_id => 'anything',
    #     :secret_access_key => 'anything',
    #     :s3_endpoint => 'localhost',
    #     :s3_hostname => 'localhost',
    #     :s3_port => 4567,
    #     :use_ssl => false,
    #     :http_wire_trace => true
    # )
  end
end
