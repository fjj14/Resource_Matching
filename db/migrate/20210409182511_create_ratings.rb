class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :reviewer_id
      t.integer :rating_number
      t.string :comment

      t.timestamps
    end
  end
end
