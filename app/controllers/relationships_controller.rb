class RelationshipsController < ApplicationController
  before_filter :signed_in_user

  # In the case of an Ajax request 
  # Rails automatically calls a JavaScript Embedded Ruby (.js.erb) 
  # file with the same name as the action
  # i.e., create.js.erb or destroy.js.erb

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    # if it's a html request, redirect_to @user
    # else call create.js
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    # if it's a html request, redirect_to @user
    # else call destroy.js
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
