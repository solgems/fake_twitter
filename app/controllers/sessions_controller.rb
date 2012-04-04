class SessionsController < ApplicationController
	def new
		# display the sign in form
	end

	def create
		user = User.find_by_email(params[:session][:email])
		# authenticate returns the user if correct pwd
		if user && user.authenticate(params[:session][:password])
			# sign the user in and redirect to the user's home page
			# sign_in is defined in sessions_helper
			sign_in user
			# take user back to intended path if any
			redirect_back_or user
		else
			# create an error message and re-render the signin form
			# flash will persist for 1 request, but render is not considered a request
			# flash.now will disappear as soon as there is an additional request
			flash.now[:error] = 'Invalid email/password combination' # Not quite right!
			render 'new'
		end
	end

	def destroy
		sign_out
		redirect_to root_path
	end
end
