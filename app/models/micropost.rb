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

	# white list of editable attributes
	attr_accessible :content, :user_id
	
	# 1 micropost belongs to 1 user
	belongs_to :user
	
	validates :content, :length => { :maximum => 140 }
end
