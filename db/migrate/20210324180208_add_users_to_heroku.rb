class AddUsersToHeroku < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :username
      t.string :first
      t.string :last

      t.timestamps
    end
  end
end
