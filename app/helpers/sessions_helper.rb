module SessionsHelper

  # used by sessions_controller & users_controller
  def sign_in(user)
    # .permanent adds the 20.years.from_now automatically
    # cookie is just like a hash, excepts it stores on the browser
    cookies.permanent[:remember_token] = user.remember_token
    # overwritten below
    current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  # setter
  def current_user=(user)
    @current_user = user
  end

  # getter
  def current_user
  	# @current_user will be set iff @current_user is nil
    @current_user ||= user_from_remember_token
  end

  # check if current user is the user id supplied
  def current_user?(user)
    user == current_user
  end

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def store_location
  	# use the request object to get the fullpath
    session[:return_to] = request.fullpath
  end

  private

    def user_from_remember_token
      remember_token = cookies[:remember_token]
      # look for any user using that cookie, unless there is no cookie found
      User.find_by_remember_token(remember_token) unless remember_token.nil?
    end

    def clear_return_to
    	session.delete(:return_to)
    end
end
