class UsersController < ApplicationController
  # ensure only signed-in users can edit and update
  before_filter :signed_in_user, only: [:index, :show, :edit, :update, :destroy]
  # ensure signed-in users can only their their own page
  before_filter :correct_user,   only: [:edit, :update]
  # to prevent admin users from even directly access the delete action
  before_filter :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page], per_page: 30)
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  # create gets called when the user submits the form at new.html.erb
  def create
    # params[:user] contains the hash of user pre-filled details
    @user = User.new(params[:user])

    # try to do a save
    if @user.save
      # save successful returns true
      # goto the show view
      # sign_in is provided by sessions_helper
      sign_in @user
      flash[:success] = "Welcome to Fake Twitter, #{@user.name}"
      # it will take you to user_path/@user.id action
      redirect_to @user
    else
      render 'new'
    end
  end

  # PUT /users/1
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      # the remember token gets reset when the user is saved, must sign_in again
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    deleted_user = User.find(params[:id]).destroy
    flash[:success] = "User #{deleted_user.name} was successfully deleted."
    redirect_to users_path
  end

  private
     def signed_in_user
      # shortcut for setting flash[:notice]
      # redirect_to signin_path, notice: "Please sign in." unless signed_in?
      unless signed_in?
        store_location  #stores the intended full path
        redirect_to signin_path, notice: "Please sign in."
      end

    end

    def correct_user
      @user = User.find(params[:id])
      # only if the currently logged in user match the user edit page they are trying to access
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
