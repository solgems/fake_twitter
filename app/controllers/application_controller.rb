class ApplicationController < ActionController::Base
  protect_from_forgery
  # helper methods are available only in views by default
  # but we make SessionsHelper to be available in the controllers
  include SessionsHelper
end
