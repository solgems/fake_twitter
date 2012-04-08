class Relationship < ActiveRecord::Base
  # only the followed_id is accessible
  attr_accessible :followed_id

  # Rails infers the names of the foreign keys from the corresponding symbols
  # (i.e., follower_id from :follower, and followed_id from :followed)
  # but since there is neither a Followed nor a Follower model we need to supply the class name User
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  # must not be empty
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
