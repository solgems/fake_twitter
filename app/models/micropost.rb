class Micropost < ActiveRecord::Base

	# white list of editable attributes
	attr_accessible :content, :user_id
	
	# 1 micropost belongs to 1 user
	belongs_to :user
	
	validates :content, :length => { :maximum => 140 }
end