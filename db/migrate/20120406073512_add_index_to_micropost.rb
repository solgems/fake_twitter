class AddIndexToMicropost < ActiveRecord::Migration
  def change
  	# create a multiple key index
  	add_index :microposts, [:user_id, :created_at]
  end
end
