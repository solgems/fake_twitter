class ApplicationController < ActionController::Base
  protect_from_forgery
  # helper methods are available only in views by default
  # but we make SessionsHelper to be available in the controllers
  include SessionsHelper

  # prevent users from accessing private info using browser's back after log-out
  # before_filter :set_no_cache

  def set_no_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
end

end
