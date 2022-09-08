class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true
      t.string :email, null: false, unique: true
      t.string :password
      t.string :name
      t.integer :user_role
      t.integer :state

      t.timestamps
    end
  end
end
