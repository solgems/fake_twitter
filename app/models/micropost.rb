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
end
