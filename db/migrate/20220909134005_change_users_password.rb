class ChangeUsersPassword < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_updated_at, :datetime
  end
end
