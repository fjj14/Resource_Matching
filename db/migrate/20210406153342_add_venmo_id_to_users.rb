class AddVenmoIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :venmo_id, :string
  end
end
