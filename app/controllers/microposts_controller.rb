class MicropostsController < ApplicationController
  # register call-backs using before_filter
  # signed_in_user defined in sessions_helper
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  # POST /microposts
  def create
    # current_user provided by sessions_helper
    @micropost = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_path
    else
      # failed to save micropost, go to user's home page
      # @micropost is retained with error messages and passed to the view
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  # DELETE /microposts/1
  def destroy
    @micropost.destroy
    redirect_back_or root_path
  end

  private
    # to check that the current user actually has a micropost with the given id
    def correct_user
      # @micropost = Micropost.find_by_id(params[:id]) is valid too but
      # for security purposes it is a good practice always to run lookups through the association
      # other users can fake the DELETE action using curl
      @micropost = current_user.microposts.find_by_id(params[:id])
      redirect_to root_path if @micropost.nil?

      # alternatively, .find raises an exception when the micropost doesn't exist
      # @micropost = current_user.microposts.find(params[:id])
      # rescue
      #   redirect_to root_path
    end
end
