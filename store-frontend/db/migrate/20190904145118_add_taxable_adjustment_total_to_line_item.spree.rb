# This migration comes from spree (originally 20150626181949)
class AddTaxableAdjustmentTotalToLineItem < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_line_items, :taxable_adjustment_total, :decimal,
               precision: 10, scale: 2, default: 0.0, null: false
    add_column :spree_line_items, :non_taxable_adjustment_total, :decimal,
               precision: 10, scale: 2, default: 0.0, null: false

    add_column :spree_shipments, :taxable_adjustment_total, :decimal,
               precision: 10, scale: 2, default: 0.0, null: false
    add_column :spree_shipments, :non_taxable_adjustment_total, :decimal,
               precision: 10, scale: 2, default: 0.0, null: false

    add_column :spree_orders, :taxable_adjustment_total, :decimal,
               precision: 10, scale: 2, default: 0.0, null: false
    add_column :spree_orders, :non_taxable_adjustment_total, :decimal,
               precision: 10, scale: 2, default: 0.0, null: false
    # TODO migration that updates old orders
  end
end
