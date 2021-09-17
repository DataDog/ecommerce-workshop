# This migration comes from spree (originally 20151220072838)
class RemoveShippingMethodIdFromSpreeOrders < ActiveRecord::Migration[4.2]
  def up
    if column_exists?(:spree_orders, :shipping_method_id, :integer)
      remove_column :spree_orders, :shipping_method_id, :integer
    end
  end

  def down
    unless column_exists?(:spree_orders, :shipping_method_id, :integer)
      add_column :spree_orders, :shipping_method_id, :integer
    end
  end
end
