class AddConditionIdToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :condition_id, :integer
  end
end
