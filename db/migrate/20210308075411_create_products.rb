class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.float :price
      t.integer :user_id
      t.integer :category_id
      t.boolean :status
      t.integer :quantity

      t.timestamps
    end
  end
end
