class AddUserLoginAttemptsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login_attempt, :integer
    add_column :users, :account_locked, :boolean, default: false
  end
end
