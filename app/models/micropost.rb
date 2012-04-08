# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Micropost < ActiveRecord::Base

	# white list of editable attributes through the web
	# allowing userid is dangerous, hacker can assign microposts to other users
	attr_accessible :content
	
	# Association methods available upon setting up relationship
	# micropost.user	Return the User object associated with the micropost.
	belongs_to :user
	
	# each micropost must have a userid
	validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 140 }

	# descending order from newest to oldest
	default_scope order: 'microposts.created_at DESC'

	# user.followed_user_ids is shorthand for user.followed_users.map(&:id)
	# which is shorthand for user.followed_users.map { |i| i.id }
	# to extract the id only instead of the whole user object
	# which returns an array of ids, so we convert to string using join()

	# the method in !-- --! is being optimized below for efficiency
	# as "user.followed_user_ids" pulls all the followed users into memory

	# !-------
	# def self.from_users_followed_by(user)
	# 	followed_user_ids = user.followed_user_ids.join(', ')
	# 	# Micropost.where is subsituted by where as we are in the Micropost model
	# 	where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
	# end
	# -------!

	default_scope :order => 'microposts.created_at DESC'

	# if a User model has "scope :admin, where(admin: true)" will make User.admin
	# lambda means anonymous function, executes the self.followed_by(user)

	# The main reason scopes are better than plain class methods is that
	# they can be chained with other methods that operate on the database,
	# eg., User.admin.paginate(page: 2)

	# Returns microposts from the users being followed by the given user.
	scope :from_users_followed_by, lambda { |user| followed_by(user) }

	private

		# Returns an SQL condition for users followed by the given user.
		# We include the user's own id as well.
		def self.followed_by(user)
			# %() produces strings such that escaping is not needed
			followed_user_ids = %(SELECT followed_id FROM relationships
								WHERE follower_id = :user_id)
			
			# SELECT * FROM microposts
			# WHERE user_id IN (SELECT followed_id FROM relationships
			#					WHERE follower_id = 1)
     		# 		OR user_id = 1
			where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
			{ user_id: user })
		end

end
