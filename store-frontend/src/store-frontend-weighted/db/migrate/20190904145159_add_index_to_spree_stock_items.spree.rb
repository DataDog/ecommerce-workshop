# This migration comes from spree (originally 20170331124513)
class AddIndexToSpreeStockItems < ActiveRecord::Migration[5.0]
  def change
    add_index :spree_stock_items, :stock_location_id
  end
end
