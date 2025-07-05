class AddUsersLowerEmailAddressIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :users, 'lower(email_address)', name: :index_users_lower_email_address_, unique: true
  end
end
