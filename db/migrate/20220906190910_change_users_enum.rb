class ChangeUsersEnum < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :user_role, :integer, :default => 0
    change_column :users, :state, :integer, :default => 1
  end
end
