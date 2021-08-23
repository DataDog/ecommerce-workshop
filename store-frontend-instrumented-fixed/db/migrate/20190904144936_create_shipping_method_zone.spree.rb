# This migration comes from spree (originally 20130228210442)
class CreateShippingMethodZone < ActiveRecord::Migration[4.2]
  class ShippingMethodZone < ApplicationRecord
    self.table_name = 'shipping_methods_zones'
  end
  def up
    create_table :shipping_methods_zones, id: false do |t|
      t.integer :shipping_method_id
      t.integer :zone_id
    end
    Spree::ShippingMethod.all.each do |sm|
      ShippingMethodZone.create!(zone_id: sm.zone_id, shipping_method_id: sm.id)
    end

    remove_column :spree_shipping_methods, :zone_id
  end

  def down
    drop_table :shipping_methods_zones
    add_column :spree_shipping_methods, :zone_id, :integer
  end
end
