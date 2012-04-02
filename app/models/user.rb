class User < ActiveRecord::Base
	attr_accessible :email, :name
	
	# 1 user have many microposts
	has_many :microposts
end
