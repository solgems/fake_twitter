class AddAdminToUsers < ActiveRecord::Migration
  def change
  	# add a default value for users already in database
    add_column :users, :admin, :boolean, default: false

  end
end
