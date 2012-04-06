class StaticPagesController < ApplicationController
  def home
    # current_user and signed_in? provided by sessions_helper
    # @micropost to be used in views/static_pages/home.html.erb
    # and eventually passed on to partials in views/shared/
    if signed_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about
  end
  
  def contact
  end
end
