class AddBuyerIdToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :buyer_id, :integer
  end
end
