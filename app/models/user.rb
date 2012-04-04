# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime        not null
#  updated_at      :datetime        not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
	# in ruby, brackets for arguments are optional
	attr_accessible :email, :name, :password, :password_confirmation
	# this method alone will compare password with password_confirmation and finally with the password_digest
	# requires bcrypy-ruby gem
	has_secure_password
	# this method will be called when @user.save is called and triggered just before it's saved
	before_save :create_remember_token

	validates :password, length: { minimum: 6 }
	validates :password_confirmation, presence: true

	# ignore cases, upper and lower case repetition not allowed
	# NOTE that setting unique here will not ensure request is not sent twice in a short time to the database
	validates :name, presence: true, length: { maximum: 50 }, uniqueness: { case_sensitive: false }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	
	# 1 user have many microposts
	has_many :microposts

	# cant be called from outside of this object, eg. via rails console
	private
	    def create_remember_token
    	  # SecureRandom is from the standard ruby library
	      self.remember_token = SecureRandom.urlsafe_base64
	    end
end
