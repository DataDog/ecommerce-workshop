# This migration comes from spree (originally 20140718133349)
class AddCustomerReturnIdToReturnItem < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_return_items, :customer_return_id, :integer
    add_index :spree_return_items, :customer_return_id, name: 'index_return_items_on_customer_return_id'
  end
end
