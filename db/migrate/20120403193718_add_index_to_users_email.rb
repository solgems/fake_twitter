class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	# add an index on the email column of the users table
  	# enforce uniqueness using unique option
  	add_index :users, :email, unique: true
  end
end
