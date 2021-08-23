# This migration comes from spree (originally 20131118050234)
class RenameTaxTotalFields < ActiveRecord::Migration[4.2]
  def change
    rename_column :spree_line_items, :tax_total, :additional_tax_total
    rename_column :spree_shipments, :tax_total, :additional_tax_total
    rename_column :spree_orders, :tax_total, :additional_tax_total

    add_column :spree_line_items, :included_tax_total, :decimal, precision: 10, scale: 2, null: false, default: 0.0
    add_column :spree_shipments, :included_tax_total, :decimal, precision: 10, scale: 2, null: false, default: 0.0
    add_column :spree_orders, :included_tax_total, :decimal, precision: 10, scale: 2, null: false, default: 0.0
  end
end
