class AddEmailUniquenessIndex < ActiveRecord::Migration
  def up
    add_index :users, :email ,:unique => true
  end

  def down
    remove_indax :users ,:email
  end
end
