# This migration comes from spree (originally 20130306191917)
class AddActiveFieldToStockLocations < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_stock_locations, :active, :boolean, default: true
  end
end
