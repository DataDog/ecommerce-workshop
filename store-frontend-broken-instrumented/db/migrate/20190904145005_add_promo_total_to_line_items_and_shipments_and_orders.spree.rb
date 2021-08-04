# This migration comes from spree (originally 20130924040529)
class AddPromoTotalToLineItemsAndShipmentsAndOrders < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_line_items, :promo_total, :decimal, precision: 10, scale: 2, default: 0.0
    add_column :spree_shipments, :promo_total, :decimal, precision: 10, scale: 2, default: 0.0
    add_column :spree_orders, :promo_total, :decimal, precision: 10, scale: 2, default: 0.0
  end
end
